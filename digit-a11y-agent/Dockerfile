# DIGIT Accessibility Scanner — production image.
#
# Multi-stage build:
#   1. deps    — install pnpm + workspace dependencies, no source code yet
#                so the layer caches when only source changes
#   2. build   — copy source, build the UI (vite produces dist/)
#   3. runtime — slim layer with built artefacts, ready to serve
#
# Image base: Playwright's official image — includes Chromium and the system
# libs Chromium needs to run headless. Saves us from manually installing
# fonts, mesa, libnss3, etc. The version below MUST match the playwright
# version in packages/api/package.json (and packages/scanner/package.json)
# or `playwright launch` will refuse to use the bundled browsers.

# ────────────────────────────────────────────────────────────────────────────
# Stage 1: install dependencies
# ────────────────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/playwright:v1.47.2-jammy AS deps

WORKDIR /app

# pnpm via corepack (ships with node 20+)
RUN corepack enable && corepack prepare pnpm@9.0.0 --activate

# Copy ONLY the workspace manifests first so this layer caches when source
# changes but dependencies don't. A real build cache here saves ~2 minutes.
COPY package.json pnpm-workspace.yaml ./
COPY packages/api/package.json       ./packages/api/
COPY packages/scanner/package.json   ./packages/scanner/
COPY packages/reporter/package.json  ./packages/reporter/
COPY packages/ui/package.json        ./packages/ui/
COPY packages/exporter/package.json  ./packages/exporter/
COPY packages/explorer/package.json  ./packages/explorer/

# pnpm strict-peer-deps off — workspace setups produce harmless peer warnings
# that would otherwise fail the build.
RUN pnpm config set strict-peer-dependencies false && \
    pnpm install --no-frozen-lockfile

# ────────────────────────────────────────────────────────────────────────────
# Stage 2: copy source + build the UI
# ────────────────────────────────────────────────────────────────────────────
FROM deps AS build
WORKDIR /app

# Base path the app is served under. Baked into the UI bundle at build time
# (Vite reads BASE_PATH → import.meta.env.BASE_URL), so assets and API calls
# resolve under e.g. /digit-a11y. Override with --build-arg BASE_PATH=/foo.
ARG BASE_PATH=/digit-a11y
ENV BASE_PATH=${BASE_PATH}

# Now the source. Anything ignored by .dockerignore won't end up here.
COPY . .

# Build the UI (vite produces packages/ui/dist/, base-prefixed by BASE_PATH).
# The API and scanner are plain JS so no build step is required — but we keep
# `pnpm --recursive run build` generic in case a package adds one later.
RUN pnpm --filter @digit-a11y/ui run build

# ────────────────────────────────────────────────────────────────────────────
# Stage 3: runtime
# ────────────────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/playwright:v1.47.2-jammy AS runtime
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.0.0 --activate

# Bring across installed deps and built source from the build stage.
COPY --from=build /app /app

# BASE_PATH must match the value baked into the UI at build time (above) so the
# API mounts its routes and serves the static UI under the same prefix.
ARG BASE_PATH=/digit-a11y
ENV NODE_ENV=production
ENV API_HOST=0.0.0.0
ENV API_PORT=3000
ENV BASE_PATH=${BASE_PATH}

EXPOSE 3000

# Single process, single port: the API serves both /api/* and the built UI
# static files under BASE_PATH. No API_KEY set → auth is off (public demo);
# set API_KEY to turn auth on.
CMD ["pnpm", "--filter", "@digit-a11y/api", "start"]

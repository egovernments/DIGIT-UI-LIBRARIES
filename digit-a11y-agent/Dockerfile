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

# pnpm strict-peer-deps off — workspace setups produce harmless peer warnings
# that would otherwise fail the build.
RUN pnpm config set strict-peer-dependencies false && \
    pnpm install --no-frozen-lockfile

# ────────────────────────────────────────────────────────────────────────────
# Stage 2: copy source + build the UI
# ────────────────────────────────────────────────────────────────────────────
FROM deps AS build
WORKDIR /app

# Now the source. Anything ignored by .dockerignore won't end up here.
COPY . .

# Build the UI (vite produces packages/ui/dist/). The API and scanner are
# plain JS so no build step is required — but we keep `pnpm --recursive run build`
# generic in case a package adds one later.
RUN pnpm --filter @digit-a11y/ui run build

# ────────────────────────────────────────────────────────────────────────────
# Stage 3: runtime
# ────────────────────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/playwright:v1.47.2-jammy AS runtime
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.0.0 --activate

# Bring across installed deps and built source from the build stage.
COPY --from=build /app /app

ENV NODE_ENV=production
ENV API_HOST=0.0.0.0
ENV API_PORT=3000
ENV UI_PORT=5173

EXPOSE 3000 5173

# Default to the API. docker-compose overrides this for the UI service.
CMD ["pnpm", "--filter", "@digit-a11y/api", "start"]

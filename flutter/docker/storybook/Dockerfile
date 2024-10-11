# Step 1: Build stage using the Flutter image
FROM ghcr.io/cirruslabs/flutter:3.22.2 AS build

# Set the argument for work directory
ARG WORK_DIR

# Define the working directory
WORKDIR /app

# Copy the project files into the Docker image
COPY ${WORK_DIR} .

# Ensure Flutter dependencies are met
RUN flutter doctor

# Clean any previous builds
RUN flutter clean

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app in release mode
RUN flutter build web --release --no-tree-shake-icons

# Step 2: Runtime stage using Nginx to serve the web app
FROM nginx:mainline-alpine

# Define the directory where the web app will be served from
ENV WEB_DIR=/var/web/story-book-flutter

# Copy the built Flutter web app from the build stage to the Nginx directory
COPY --from=build /app/build/web/ ${WEB_DIR}/

# Copy the custom Nginx configuration file
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf

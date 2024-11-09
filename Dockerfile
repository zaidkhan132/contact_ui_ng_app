# Stage 1: Build Stage
FROM node:16-alpine AS builder

# Set the working directory
WORKDIR /usr/local/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Build the Angular application
RUN npm run build

# Stage 2: Production Stage
FROM nginx:latest

# Copy build output from the builder stage
COPY --from=builder /usr/local/app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

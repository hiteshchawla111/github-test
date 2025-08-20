# Step 1: Build React app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency files first
COPY package*.json ./

RUN npm install

# Copy all source code
COPY . .

# Build React app (creates /dist folder)
RUN npm run build


# Step 2: Serve built app with "serve"
FROM node:18-alpine

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy dist folder from builder stage
COPY --from=builder /app/dist ./dist

# Expose port 3000
EXPOSE 3000

# Start app
CMD ["serve", "-s", "dist", "-l", "3000"]

# -------- Stage 1 : Build Stage --------
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# -------- Stage 2 : Production Stage --------
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only required files from builder stage
COPY --from=builder /app /app

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

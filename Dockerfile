# Stage 1: Install dependencies and build the Next.js application
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy only package.json and package-lock.json for efficient caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the current directory to the container
COPY . .

# Build the Next.js app
RUN npm run build

# Stage 2: Production environment
FROM node:18-alpine AS runner

# Set working directory
WORKDIR /app

# Copy necessary files from the builder stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# Install only production dependencies
RUN npm install --only=production

# Set environment variable to production
ENV NODE_ENV=production

# Expose port 3000
EXPOSE 8080

# Start the application
CMD ["npm", "run", "start"]

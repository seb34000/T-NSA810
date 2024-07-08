# Build stage
FROM node:14-alpine AS builder

WORKDIR /usr/src/app

# Copy the application code
COPY . .

# Install dependencies
RUN apk update && apk add --no-cache g++ make python3
RUN yarn install

# Runtime stage
FROM node:14-alpine

# Go to Working Directory
WORKDIR /usr/src/app

# Copy the application code from the build stage
COPY --from=builder /usr/src/app .

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create a non root user 
RUN chown -R appuser:appgroup /usr/src/app
USER appuser

EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]

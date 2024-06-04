# Build stage
FROM node:14-alpine AS builder
WORKDIR /app
COPY . .
RUN apk update && apk add --no-cache g++ make python3
RUN yarn install
RUN yarn build

# Deployment stage
FROM node:14-alpine
WORKDIR /app
COPY --from=builder /app/build /app
RUN apk update && apk add --no-cache yarn
RUN yarn global add serve
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser
CMD ["serve", "-p", "80", "-s", "/app"]

FROM node:22-alpine

WORKDIR /usr/src/app

# Install dependencies
COPY app/package*.json ./
RUN npm install --production

# Copy application source
COPY app/ .

# Default port
ENV PORT=3000
EXPOSE 3000

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["node", "index.js"]

FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production && npm install concurrently

COPY . .

WORKDIR /app/providers/hianime
RUN npm install

WORKDIR /app

# Use 'concurrently' to start both servers: main app and hianime (in background)
CMD ["npx", "concurrently", "--raw", "\"npm start\"", "\"cd providers/hianime && npm start\""]

FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production && npm install concurrently

COPY . .

WORKDIR /app/providers/hianime
RUN npm install

WORKDIR /app

# Create an entrypoint script to write the cookie content from env variable, then start apps
RUN echo '#!/bin/sh\n\
if [ ! -z "$COOKIE_TXT_CONTENT" ]; then\n\
  echo "$COOKIE_TXT_CONTENT" > /app/cookies.txt\n\
fi\n\
npx concurrently --raw "npm start" "cd providers/hianime && npm start"\n' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

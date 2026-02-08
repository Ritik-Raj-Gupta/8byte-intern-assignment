FROM node:24.0.0-alpine
WORKDIR /app
COPY package.json ./package.json
RUN npm install
COPY app.js ./app.js 
EXPOSE 3000
CMD ["node", "app.js"]
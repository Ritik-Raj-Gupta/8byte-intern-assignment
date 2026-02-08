FROM node:24.0.0-alpine
WORKDIR /app
COPY app/package.json ./package.json
RUN npm install
COPY app/app.js ./app.js 
EXPOSE 3000
CMD ["node", "app.js"]
FROM node:latest

WORKDIR /my-app

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 8080

CMD ["node", "index.js"]
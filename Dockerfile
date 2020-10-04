# Builder Stage
FROM node:alpine as builder
WORKDIR '/usr/src/app'
ENV CHOKIDAR_USEPOLLING=true
COPY ./package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# Run Stage
FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
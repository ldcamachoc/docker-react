FROM node:current-alpine3.10
WORKDIR '/app'
COPY package*.json ./
RUN echo $(ls -1 /app)
RUN npm install
COPY . ./
RUN echo $(ls -1 /app)
RUN echo "----------"
RUN npm run build --production --silent
RUN echo $(ls -1 /app)
RUN echo "----------"
RUN echo $(ls -1 /app/build)

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

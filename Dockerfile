FROM node:alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
# Needed by AWS beanstalk. Doesn't do anything automatically in your laptop, but AWS uses it to map the port automatically.
EXPOSE 80   
COPY --from=builder /app/build /usr/share/nginx/html
# the default command of nging image is to start nginx
# sono need to give nginx start command.
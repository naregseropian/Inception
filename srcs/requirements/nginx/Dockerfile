# requirements/nginx/Dockerfile
FROM alpine:3.19
RUN apk add --no-cache nginx
COPY ./conf /etc/nginx/conf.d
CMD ["nginx", "-g", "daemon off;"]

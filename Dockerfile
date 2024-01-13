FROM nginx

ARG SRC_PATH=Output

COPY $SRC_PATH /usr/share/nginx/html


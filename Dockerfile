FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY slides.html /usr/share/nginx/html/slides.html
COPY slides-en.html /usr/share/nginx/html/slides-en.html
COPY slides.pdf /usr/share/nginx/html/slides.pdf
COPY assets/ /usr/share/nginx/html/assets/
COPY nginx.conf /etc/nginx/templates/default.conf.template
CMD sh -c "sed -i \"s|__OPENAI_API_KEY__|${OPENAI_API_KEY:-not-set}|g\" /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"

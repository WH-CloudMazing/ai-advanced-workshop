FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY slides.html /usr/share/nginx/html/slides.html
COPY slides-en.html /usr/share/nginx/html/slides-en.html
COPY slides.pdf /usr/share/nginx/html/slides.pdf
COPY slides-en.pdf /usr/share/nginx/html/slides-en.pdf
COPY assets/ /usr/share/nginx/html/assets/
COPY nginx.conf /etc/nginx/templates/default.conf.template
COPY docker-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

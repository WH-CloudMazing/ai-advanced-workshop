FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY slides.html /usr/share/nginx/html/slides.html
COPY slides.pdf /usr/share/nginx/html/slides.pdf
COPY assets/ /usr/share/nginx/html/assets/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

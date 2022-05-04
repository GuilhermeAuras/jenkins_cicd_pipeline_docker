FROM nginx:latest
LABEL Author="Guilherme Auras" 
RUN echo "<html> <h1> Bem vindo ao site do bill !!! </h1> </html>" > /usr/share/nginx/html/index.html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;"]

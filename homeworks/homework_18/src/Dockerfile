#basic image
FROM ubuntu:latest

# Update and install apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
     rm -rf /var/lib/apt/lists/*

#Add html file     
RUN echo "Hello, DanIt. This is my HW18" > /var/www/html/index.html   

# Expose port 80
EXPOSE 80

# Start apache server in foreground (so the container keeps running)
CMD ["apachectl", "-D", "FOREGROUND"]


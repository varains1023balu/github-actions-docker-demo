#stage@1 Pulling Rocky Linux Image
FROM rockylinux:9 AS builder

#Set Working Dir
WORKDIR /app

#Build args
ARG HTML_FILE=v1.html

#Coping Webpage Pages
COPY ${HTML_FILE} index.html 

#Coping Webpage Pages
COPY images ./images

#Stage @2 Pulling Rocky Linux Image
FROM rockylinux:9

#Install Apache(httpd) Package
RUN dnf install httpd -y && \ 
    dnf clean all

#Setup Working Dir
WORKDIR /var/www/html/

# Copy everything from builder
copy --from=builder /app/ /var/www/html/

#Port no
EXPOSE 80

#Starting Apache (httpd) the Service
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

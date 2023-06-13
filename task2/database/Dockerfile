# Use a base image
FROM ubuntu:latest

# Silent installation of postgres
ARG DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Copy the server setup files to the container
COPY /src /app
COPY docker-compose.yaml /app
COPY studentDetails.txt /app
COPY generate.sh /app

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean && \
    apt-get install acl && \
    apt-get install -y vim && \
    apt-get install -y apache2 && \
    apt-get install -y apache2-utils && \
    apt-get install -y postgresql && \
    apt-get install -y postgresql-contrib && \
    rm -rf /var/lib/apt/lists/*

# Makes a md5 hash based connection for all the IP addresses which connect to the database
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/13/main/pg_hba.conf

# We are making postgres listen to all the network interfaces
RUN echo "listen_addresses='*'" >> /etc/postgresql/13/main/postgresql.conf

# Run the setup scripts
RUN chmod +x /app/genstudent.sh && \
    chmod +x /app/permit.sh && \
    chmod +x /app/feebreakup.sh && \
    chmod +x /app/feedefaulter.sh && \
    chmod +x /app/allocatemess.sh && \
    chmod +x /app/signout.sh && \
    chmod +x /app/generate.sh && \
    ./genstudent.sh

RUN ./generate.sh

# Set up the servername and alias and copy the mess.txt file into the webserver directory
RUN mkdir -p /var/www/gammaz.hm && \
    cp /home/had/mess.txt /var/www/gammaz.hm/mess.txt && \
    cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/gammaz.hm.conf 

EXPOSE 80 
EXPOSE 5432

CMD ["service", "postgresql", "start", "&&", "tail", "-f", "/dev/null"]



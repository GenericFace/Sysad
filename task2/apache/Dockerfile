# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy the server setup files to the container
COPY . /app

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean && \
    apt-get install acl && \
    apt-get install -y vim && \
    apt-get install -y apache2 && \
    apt-get install -y apache2-utils && \
    rm -rf /var/lib/apt/lists/*

# Run the setup scripts
RUN chmod +x /app/genstudent.sh && \
    chmod +x /app/permit.sh && \
    chmod +x /app/feebreakup.sh && \
    chmod +x /app/feedefaulter.sh && \
    chmod +x /app/allocatemess.sh && \
    chmod +x /app/signout.sh && \
    chmod +x apa.sh && \
    ./genstudent.sh

EXPOSE 80 

RUN ./apa.sh

RUN service apache2 start

CMD ["tail", "-f", "/dev/null"]


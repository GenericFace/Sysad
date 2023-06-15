# Use a base image
FROM ubuntu:latest as base

# Silent installation of postgres
ARG DEBIAN_FRONTEND=noninteractive

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
    rm -rf /var/lib/apt/lists/*

# Run the setup scripts
RUN chmod +x /app/genstudent.sh && \
    chmod +x /app/permit.sh && \
    chmod +x /app/feebreakup.sh && \
    chmod +x /app/feedefaulter.sh && \
    chmod +x /app/allocatemess.sh && \
    chmod +x /app/signout.sh && \
    chmod +x /app/generate.sh && \
    ./genstudent.sh

RUN ./ok.sh

EXPOSE 80 

CMD ["tail", "-f", "/dev/null"]



# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy the server setup files to the container
COPY src/genstudent.sh /app
COPY src/studentDetails.txt /app
COPY src/permit.sh /app
COPY src/allocatemess.sh /app
COPY src/feebreakup.sh /app
COPY src/feedefaulter.sh /app
COPY src/signout.sh /app
COPY src/feeBreakup.txt /app
COPY src/mess.txt /app

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean && \
    apt-get install acl && \
    rm -rf /var/lib/apt/lists/*

# Run the setup scripts
RUN chmod +x /app/genstudent.sh && \
    chmod +x /app/permit.sh && \
    chmod +x /app/feebreakup.sh && \
    chmod +x /app/feedefaulter.sh && \
    chmod +x /app/allocatemess.sh && \
    chmod +x /app/signout.sh && \
    ./genstudent.sh
    
RUN sed -i 's/localhost/gamma-z.hm/g' /etc/hosts

# Expose the required ports
EXPOSE 80 443

# Set the entry point to keep the container running
CMD ["tail", "-f", "/dev/null"]

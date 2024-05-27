# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y \
        libsm6 \
        libxext6 \
        libxrender-dev \
        xvfb

# Set the DISPLAY environment variable
ENV DISPLAY=:99.0

# Run flask app
CMD ["python", "your_script.py"]

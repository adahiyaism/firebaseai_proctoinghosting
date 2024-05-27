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
        xvfb \
        scrot \
        python3-tk \
        python3-dev

# Set up a virtual display
ENV DISPLAY=:99

# Start Xvfb in the background
CMD ["Xvfb", ":99", "-screen", "0", "1280x1024x16", "-ac"]

# Run your application
CMD ["python", "your_script.py"]

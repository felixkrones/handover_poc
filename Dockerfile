# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

# Define the base image. We use the same base image as the genaihd_handover container.
FROM python:3.11

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# We need to set the working directory to /app so that the application can find the files it needs.
WORKDIR /app

# Copy what we need from the genaihd_handover container. For now, just copy everything.
COPY . .

# Download dependencies
RUN python -m pip install -r requirements.txt

# Expose the port that the application listens on.
EXPOSE 443

# Run the application.
ENTRYPOINT ["streamlit", "run", "handover.py", "--server.port=443", "--server.address=0.0.0.0"]

# Run the following command on gcloud: 
# gloud builds submit --tag LOCATION-docker.pkg.dev/PROJECT-ID/REPO/IMAGE:TAG .
# Locally run: 
# sudo docker build -t image_name .
# sudo docker run -p 443:443 image_name

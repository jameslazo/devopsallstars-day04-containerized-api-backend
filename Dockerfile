FROM python:3.9-slim

# Create non-root user
RUN useradd -m -s /bin/bash sp-api-user

# Set the working directory inside the container
WORKDIR /app

# Change ownership of the working directory & switch to user
RUN chown -R sp-api-user:sp-api-user /app
USER sp-api-user

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Copy all files from the current directory into the container
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]

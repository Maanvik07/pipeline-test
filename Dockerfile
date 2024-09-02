# Use an official Python image as a parent image
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on (adjust as needed for your application)
EXPOSE 8000

# Define the command to run the application
# Replace 'app.py' with the entry point of your application
CMD ["python", "main.py"]

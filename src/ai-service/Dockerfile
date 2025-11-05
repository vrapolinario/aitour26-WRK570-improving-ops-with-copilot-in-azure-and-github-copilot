# Use the official Python image as the base image
FROM python:3.12.7-alpine

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory to /app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt \
	&& rm -rf /root/.cache/pip

# Copy only necessary files (adjust as needed)
COPY main.py ./
COPY src/ ./src/
COPY assets/ ./assets/
COPY requirements.txt ./
COPY README.md ./
# If you need other files, add them explicitly

# Set permissions for app files
RUN chown -R appuser:appgroup /app

# Expose port 5001 for the FastAPI application
EXPOSE 5001

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Switch to non-root user
USER appuser

# Add healthcheck for the service
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD wget --spider -q http://localhost:5001/health || exit 1

# Start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5001"]
FROM python:3.12-slim

WORKDIR /app

# Install only required dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    xclip \
    && rm -rf /var/lib/apt/lists/*

# Copy files
COPY . .

# Save the modified tools.py
COPY docker/tools.py chapito/tools/tools.py

# Install Python dependencies
RUN pip install -r requirements.txt
# Alternative if you want to use pyproject.toml:
# RUN pip install -e .

# Create browser profile directory
RUN mkdir -p /app/browser_profile

# Expose port for any potential web interface
EXPOSE 5001

# Set environment variable for remote chrome
ENV REMOTE_CHROME_HOST=chrome
ENV REMOTE_CHROME_PORT=4444

# Default command
CMD ["python", "main.py", "--host", "0.0.0.0", "--use-browser-profile", "--verbosity", "3"]
# Base Python image
FROM python:3.9-slim

WORKDIR /app

# System dependencies (optional but safe for transformers, torch, yt-dlp, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ffmpeg \
 && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

# Set Gradio environment + USER_AGENT for SerpAPI
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=8080
ENV USER_AGENT="KnightCorp-RPGSearchBot/1.0"

CMD ["python", "app/webui.py"]

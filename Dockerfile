FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv for fast Python package management
RUN pip install uv

# Copy the project files
COPY . .

# Install project dependencies
RUN uv sync

# Install mcp-proxy
RUN uv pip install mcp-proxy

# Expose port 80
EXPOSE 80

# Set environment variables
ENV PYTHONPATH=/app/src

# Run the MCP proxy with streamable HTTP transport on port 80
#CMD ["uv", "run", "mcp-proxy", "--debug", "--transport", "streamablehttp", "--host", "0.0.0.0", "--port", "80", "--pass-environment", "python", "--", "src/universal_mcp_coda/server.py"]
CMD ["python", "src/universal_mcp_coda/server.py"]

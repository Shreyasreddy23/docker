# ---- Base image ----
# Start from an official, lightweight Python image.
# "slim" = smaller size than the full python image, still has what we need.
FROM python:3.12-slim

# ---- Working directory ----
# All following commands (COPY, RUN, CMD) run from this folder INSIDE the container.
WORKDIR /app

# ---- Install dependencies FIRST ----
# We copy only requirements.txt before the rest of the code on purpose:
# Docker caches each step. If your code changes but requirements.txt doesn't,
# Docker reuses the cached "pip install" step instead of redoing it -> faster builds.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Copy the rest of the app code ----
COPY . .

# ---- Document the port the app listens on ----
# This does NOT actually publish the port (that's done with -p at runtime),
# it's just documentation for humans and tools.
EXPOSE 5000

# ---- Default command when the container starts ----
CMD ["python3", "app.py"]

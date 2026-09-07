# Docker Hello World — Practice Project

A tiny Flask web app used to practice the full Docker workflow:
build an image, run a container, and manage it with Docker Compose.

## Project files
- `app.py` — the Flask app (shows a visit counter + container hostname)
- `requirements.txt` — Python dependencies
- `Dockerfile` — instructions to build the image
- `docker-compose.yml` — config to run/manage the container
- `.dockerignore` — files excluded from the image

---

## Part 1: Plain Docker (no Compose)

```bash
# 1. Build the image (run this from inside the project folder)
docker build -t hello-docker .

# 2. Check the image was created
docker images

# 3. Run a container from the image
docker run -d -p 5000:5000 --name hello-docker-app hello-docker

# 4. Check it's running
docker ps

# 5. Open in browser or curl it
curl http://localhost:5000/

# 6. View logs
docker logs -f hello-docker-app

# 7. Stop it
docker stop hello-docker-app

# 8. Start it again (same container, doesn't rebuild)
docker start hello-docker-app

# 9. Restart it
docker restart hello-docker-app

# 10. Remove the container when you're done (must be stopped first)
docker stop hello-docker-app
docker rm hello-docker-app

# 11. Remove the image too, if you want to fully clean up
docker rmi hello-docker
```

---

## Part 2: Using Docker Compose (recommended way)

Compose reads `docker-compose.yml` so you don't have to type long commands.

```bash
# Build the image AND start the container, in the background
docker compose up -d --build

# Check status
docker compose ps

# View live logs
docker compose logs -f

# Stop the container (keeps it, just paused)
docker compose stop

# Start it again
docker compose start

# Restart it
docker compose restart

# Stop AND remove the container (image stays on your machine)
docker compose down

# Rebuild after you change app.py or requirements.txt
docker compose up -d --build
```

Visit **http://localhost:5000** in your browser after `up`. Refresh a few
times to watch the visit counter increase — that proves the same container
is handling every request.

---

## Things to point out to your senior

1. **`docker build -t hello-docker .`** — builds an image from the Dockerfile
2. **`docker compose up -d`** — same idea, but declarative and repeatable via YAML
3. Refresh the page a few times → counter increases → shows the app is stateful
   *while the container is running*
4. Run `docker compose down` then `docker compose up -d` again → counter resets to 0,
   because a brand-new container was created (nothing persisted)
5. The `volumes: - .:/app` line means you can edit `app.py` locally and see
   changes without rebuilding — nice for development

## Suggested next step
Add a real database (e.g. PostgreSQL or Redis) as a second service in
`docker-compose.yml`, so the counter survives even after `docker compose down`.

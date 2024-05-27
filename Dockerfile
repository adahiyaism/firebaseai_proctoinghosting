# Stage 1: Builder
FROM python:3-alpine AS builder

WORKDIR /app

RUN python3 -m venv venv
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt

# Stage 2: Runner
FROM python:3-alpine AS runner

# Install xvfb and its dependencies
RUN apk update && \
    apk add --no-cache xvfb run-parts && \
    rm -rf /var/cache/apk/*

WORKDIR /app

COPY --from=builder /app/venv venv
COPY app.py app.py

ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV FLASK_APP=app.py
ENV DISPLAY=:99

EXPOSE 8080

# Use xvfb-run to start the application
CMD ["xvfb-run", "--auto-servernum", "gunicorn", "--bind", ":8080", "--workers", "2", "app:app"]

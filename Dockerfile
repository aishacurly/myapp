# Stage 1 — Builder
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

COPY app.py .

# Stage 2 — Runtime (minimal)
FROM python:3.11-slim AS runtime

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copy only what we need from builder
COPY --from=builder /root/.local /home/appuser/.local
COPY --from=builder /app/app.py .

# Switch to non-root user
USER appuser

ENV PATH=/home/appuser/.local/bin:$PATH

EXPOSE 5000

CMD ["python", "app.py"]


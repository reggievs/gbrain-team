FROM oven/bun:1 AS base
WORKDIR /app

RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

RUN bun install -g github:garrytan/gbrain

ENV PATH="/root/.bun/bin:$PATH"

EXPOSE 8080

CMD ["sh", "-c", "GBRAIN_DISABLE_DIRECT_POOL=1 gbrain apply-migrations --yes 2>&1 | tail -5; exec gbrain serve --http --port ${PORT:-8080} --bind 0.0.0.0"]

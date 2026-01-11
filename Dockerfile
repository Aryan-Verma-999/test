# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1-debian AS base

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy everything
COPY package.json bun.lock bun.lockb ./
COPY packages ./packages
COPY config.json ./

# Install dependencies (this will link workspaces properly)
RUN HUSKY=0 bun install --frozen-lockfile

EXPOSE 8080/tcp

# Run the homeserver package
CMD ["bun", "run", "packages/homeserver/src/index.ts"]

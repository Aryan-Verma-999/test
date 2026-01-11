# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1-debian AS base

WORKDIR /app

# Install dependencies
FROM base AS install
COPY package.json bun.lock bun.lockb ./
COPY packages ./packages
RUN HUSKY=0 bun install --frozen-lockfile

# Production image
FROM base AS release

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy installed node_modules and source
COPY --from=install /app/node_modules ./node_modules
COPY --from=install /app/packages ./packages
COPY package.json bun.lock bun.lockb ./
COPY config.json ./

EXPOSE 8080/tcp

# Run the homeserver package
CMD ["bun", "run", "--cwd", "packages/homeserver", "dev"]


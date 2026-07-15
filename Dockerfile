# syntax=docker/dockerfile:1

ARG NODE_VERSION=20

# ---- Base ----
FROM node:${NODE_VERSION}-bookworm-slim AS base
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/app

# ---- Dependencies ----
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# ---- Build ----
FROM base AS build
ENV NODE_ENV=production
COPY --from=deps /opt/app/node_modules ./node_modules
COPY . .
RUN npm run build

# ---- Runtime ----
FROM node:${NODE_VERSION}-bookworm-slim AS runtime
ENV NODE_ENV=production
WORKDIR /opt/app

RUN groupadd -r strapi && useradd -r -g strapi -m strapi

COPY --from=build /opt/app/node_modules ./node_modules
COPY --from=build /opt/app/package.json ./package.json
COPY --from=build /opt/app/tsconfig.json ./tsconfig.json
COPY --from=build /opt/app/dist ./dist
COPY --from=build /opt/app/.strapi ./.strapi
COPY --from=build /opt/app/public ./public
COPY --from=build /opt/app/config ./config
COPY --from=build /opt/app/database ./database
COPY --from=build /opt/app/src ./src
COPY --from=build /opt/app/favicon.png ./favicon.png

RUN mkdir -p .tmp public/uploads && chown -R strapi:strapi /opt/app

USER strapi

EXPOSE 1337

CMD ["npm", "run", "start"]

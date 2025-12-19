# =========================
# STAGE 1 — build
# =========================
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$PATH"

RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
RUN flutter doctor

WORKDIR /app

# Копируем ТОЛЬКО нужное
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter build web

# =========================
# STAGE 2 — runtime
# =========================
FROM nginx:alpine

# GitHub Pages / SPA fix
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

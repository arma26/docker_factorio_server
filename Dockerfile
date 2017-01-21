FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./new_smart_launch.sh /opt/
COPY ./factorio.crt /opt/

VOLUME /opt/factorio/saves /opt/factorio/mods

EXPOSE 34197/udp
EXPOSE 27015/tcp

ENV VERSION=0.14.21 \
    FACTORIO_SHA1=fc11c0d5b2671e0cf36db7907de6ff617525ede3 \
    FACTORIO_SERVER_NAME= \
    FACTORIO_SERVER_DESCRIPTION= \
    # FACTORIO_TOKEN= \
    FACTORIO_ADMIN_ONLY_PAUSE=true \
    FACTORIO_AFK_KICK_INTERVAL=0 \
    FACTORIO_ALLOW_COMMANDS=admins-only \
    FACTORIO_AUTOSAVE_INTERVAL=10 \
    FACTORIO_AUTOSAVE_ONLY_ON_SERVER=true \
    FACTORIO_AUTOSAVE_SLOTS=5 \
    FACTORIO_AUTO_PAUSE=true \
    FACTORIO_CREDENTIALS_PASS= \
    FACTORIO_CREDENTIALS_USER= \
    FACTORIO_GAME_PASSWORD= \
    FACTORIO_MAX_PLAYERS=0 \
    FACTORIO_MAX_UPLOADS_KBPS=0 \
    FACTORIO_MINIMUM_LATENCY_TICKS=0 \
    FACTORIO_RCON_PASSWORD= \
    FACTORIO_REQUIRE_USER_VERIFICATION=true \
    FACTORIO_RETURNING_PLAYER_LIMIT=false \
    FACTORIO_SAVE= \
    FACTORIO_VISIBILITY_LAN=true \
    FACTORIO_VISIBILITY_PUBLIC=true

CMD ["./new_smart_launch.sh"]

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$FACTORIO_SHA1  /tmp/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    rm /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    apk del curl

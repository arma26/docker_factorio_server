FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./new_smart_launch.sh /opt/

VOLUME /opt/factorio/saves /opt/factorio/mods

EXPOSE 34197/udp
EXPOSE 27015/tcp

ENV VERSION= \
    FACTORIO_SHA1= \
    FACTORIO_FILENAME=factorio_headless_x64.tar.xz \
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

RUN apk --update add bash curl xz && \
    curl -L https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /tmp/$FACTORIO_FILENAME && \
    echo "$FACTORIO_SHA1  /tmp/$FACTORIO_FILENAME" | sha1sum -c && \
    xz --decompress /tmp/$FACTORIO_FILENAME && \
    tar xvf /tmp/*.tar && \
    rm -rf /tmp/*.tar && \
    apk del curl

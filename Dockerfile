FROM alpine/git
RUN apk --no-cache add curl
RUN curl -sL https://github.com/DanySK/Gravis-CI/raw/master/autotag >> /bin/autotag
RUN chmod +x /bin/autotag
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

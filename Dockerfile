FROM nginx:alpine
ENV SYNC_FROM="manjaro.moson.eu/repos"
ENV CRON_PATTERN="*/30 * * * *"
ENV USER_ID=""
ENV GROUP_ID=""
RUN apk add rsync
COPY content /
EXPOSE 80
CMD ./scripts/start
VOLUME /web
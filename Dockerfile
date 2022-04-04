FROM perl:5.34 as env
RUN cpanm Carton \
    && mkdir -p /usr/src/line-bot

FROM env as builder
COPY cpanfile* /usr/src/line-bot
WORKDIR /usr/src/line-bot
RUN carton install

FROM builder AS runner
COPY . /usr/src/line-bot
WORKDIR /usr/src/line-bot
CMD [ "carton", "exec", "starman","-p", "8080", "./welcome-bot.psgi" ]

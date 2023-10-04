FROM node:18

RUN apt-get update
RUN apt-get install -y \
    ruby-full \
    build-essential \
    zlib1g-dev \
    openjdk-17-jdk \
    curl
RUN gem install jekyll bundler
RUN npm install -g fsh-sushi gofsh

USER node
WORKDIR /work

RUN ruby --version && \
    node --version && \
    npm --version && \
    java --version && \
    jekyll --version && \
    bundler --version && \
    sushi --version

COPY ./_genonce.sh ./_genonce.sh
COPY ./_updatePublisher.sh ./_updatePublisher.sh
COPY ./ig.ini ./ig.ini
COPY ./sushi-config.yaml ./sushi-config.yaml

RUN ./_updatePublisher.sh -y

COPY ./input ./input

RUN ./_genonce.sh

RUN ls -l output

CMD [ "cp", "-a", "/work/output/.", "/output" ]

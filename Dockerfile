FROM alpine:3.19

ARG YQ_VERSION=4.18.1
ARG SCM_VERSION=1.7.0
ARG SCM_FILE=scm-backup-1.7.0.6090ea9.zip
ARG DOTNET_FILE=dotnet-runtime-3.1.22-linux-musl-x64.tar.gz
ARG DOTNET_FILE_SHA512=708d17a4f3fc0bb866343f359e88543c99c70511d1d90fa3c889ce126bd2625f2ce3118552dbea52b3410b70586ad5f551453de41c6cb88ec77e131854979955

ENV SCM_ROOT=/opt/scm-backup
ENV DOTNET_ROOT=/opt/dotnet
ENV PATH=${PATH}:${DOTNET_ROOT}

WORKDIR ${SCM_ROOT}

RUN apk add --no-cache \
 # Install deps
        bash icu-libs krb5-libs \
        libgcc libintl libssl1.1 \
        libstdc++ zlib curl git \
 && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing pixz \
 # Install dotnet runtime
 && curl -fsL -o ${DOTNET_FILE} https://download.visualstudio.microsoft.com/download/pr/787e6ae7-03a1-44c3-849f-ed85b25ff620/c6f4cfe60b5dc12cb2032a580c8e4c58/${DOTNET_FILE} \
 && echo "${DOTNET_FILE_SHA512}  ${DOTNET_FILE}" > ${DOTNET_FILE}.sha512 \
 && sha512sum -c ${DOTNET_FILE}.sha512 \
 && mkdir -p ${DOTNET_ROOT} \
 && tar zxf ${DOTNET_FILE} -C ${DOTNET_ROOT} \
 # Install scm-backup
 && curl -fsL -o ${SCM_FILE} https://github.com/christianspecht/scm-backup/releases/download/${SCM_VERSION}/${SCM_FILE} \
 && unzip ${SCM_FILE} \
 && rm -f ${SCM_FILE} ${DOTNET_FILE} ${DOTNET_FILE}.sha512 \
 # Install yq (config templating)
 && curl -fSL https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -o /usr/local/bin/yq \
 && chmod +x /usr/local/bin/yq

COPY entrypoint.sh /usr/local/bin
COPY settings.yml .
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

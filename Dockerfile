FROM alpine:3.15

ARG YQ_VERSION=4.15.1
ARG SCM_VERSION=1.6.0
ARG SCM_FILE=scm-backup-1.6.0.5c3e3ea.zip
ARG DOTNET_FILE=dotnet-runtime-3.1.21-linux-musl-x64.tar.gz
ARG DOTNET_FILE_SHA512=73e7fb6f7ddd4e6e7891fd006d18c4cfb07120dd4fd15458b01656540c77df667704d3c9068dea1177ea37fccbefd7bcec0c7d2e58660859e7ac8bc6cfff07f7

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
 && curl -fsL -o ${DOTNET_FILE} https://download.visualstudio.microsoft.com/download/pr/75ccece0-e943-4564-837f-ce2dc2daa2b8/f35237bcdb87c74cae4c50b84fd11907/${DOTNET_FILE} \
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

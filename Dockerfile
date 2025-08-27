FROM alpine:3.22

ARG SCM_VERSION=1.10.0
ARG SCM_FILE=scm-backup-1.10.0.c9d19ac.zip
ARG SCM_SHA256=c61351cef35d570d17bc785b9a83cd6962480eb730a79cbafd1aa8400573826e

ENV SCM_ROOT=/opt/scm-backup
ENV SCM_LOCAL_FOLDER=${SCM_ROOT}/backup
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

WORKDIR ${SCM_ROOT}

RUN apk add --no-cache git yq pixz aspnetcore8-runtime \
    # Install scm-backup
    && wget https://github.com/christianspecht/scm-backup/releases/download/${SCM_VERSION}/${SCM_FILE} \
    && echo "${SCM_SHA256} ${SCM_FILE}" | sha256sum -c - \
    && unzip ${SCM_FILE} \
    && rm -f ${SCM_FILE} \
    && mkdir -p ${SCM_LOCAL_FOLDER}

COPY settings.yml .
COPY --chmod=0755 entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]

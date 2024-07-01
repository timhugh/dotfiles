FROM alpine:3.12

RUN apk add --update --no-cache \
    samba-common-tools \
    samba-server \
    samba-client \
    && rm -rf /var/cache/apk/*

EXPOSE 445/tcp

HEALTHCHECK --interval=60s --timeout=15s \
    CMD smbclient -L localhost -U % -m SMB3

VOLUME [ "/etc", "/run/samba", "/var/cache/samba", "/var/lib/samba", "/var/log/samba" ]

COPY smb.conf /etc/samba/smb.conf

CMD ["smbd", "--foreground", "--log-stdout", "--no-process-group"]


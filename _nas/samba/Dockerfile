FROM alpine:3.12

RUN apk add --update --no-cache \
    samba-common-tools \
    samba-server \
    samba-client \
    && rm -rf /var/cache/apk/*

EXPOSE 445/tcp

HEALTHCHECK --interval=60s --timeout=15s \
    CMD smbclient -L localhost -U % -m SMB3

# these GIDS match the host
RUN addgroup -g 1001 vault 
RUN addgroup -g 1002 private

VOLUME [ "/etc", "/run/samba", "/var/cache/samba", "/var/lib/samba", "/var/log/samba" ]

COPY add-smb-user.sh /usr/local/bin/add-smb-user.sh
RUN chmod +x /usr/local/bin/add-smb-user.sh

COPY smb.conf /etc/samba/smb.conf

CMD ["smbd", "--foreground", "--log-stdout", "--no-process-group"]


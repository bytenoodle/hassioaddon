ARG BUILD_FROM
FROM ghcr.io/rdiger-36/haspelsync:1.4.0

# Add script and default config
COPY run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

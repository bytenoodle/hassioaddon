ARG BUILD_FROM
FROM ghcr.io/rdiger-36/bambulab-ams-spoolman-filamentstatus:1.2.1

# Add script and default config
COPY run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

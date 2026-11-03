FROM debian:12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    libwebkit2gtk-4.0-37 \
    libfreetype6 \
    libgsf-1-114 \
    fonts-liberation \
    procps \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/ru_RU.UTF-8/s/^# //' /etc/locale.gen && locale-gen
ENV LANG=ru_RU.UTF-8
ENV LC_ALL=ru_RU.UTF-8

# Копируем установщик (он должен лежать рядом с Dockerfile)
COPY setup-full-8.3.27.2342-x86_64.run /tmp/setup.run

RUN chmod +x /tmp/setup.run && \
    /tmp/setup.run --mode unattended --disable-components client_full --enable-components server,server_admin && \
    rm /tmp/setup.run

RUN mkdir -p /home/usr1cv8/.1cv8/1C/1cv8 && \
    chown -R usr1cv8:grp1cv8 /home/usr1cv8/.1cv8

EXPOSE 1540 1541 1560-1591

CMD ["/opt/1cv8/x86_64/8.3.27.2342/ragent", "-port", "1540", "-d", "/home/usr1cv8/.1cv8/1C/1cv8"]

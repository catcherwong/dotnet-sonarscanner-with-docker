FROM openjdk:17-slim-bullseye

# change the source, if necessary
# RUN cp /etc/apt/sources.list /etc/apt/sources.list_bak \
#     && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
#     && sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

WORKDIR /project

COPY run.sh ./
COPY nuget.config ./

RUN apt-get update \
    && apt-get install \
    wget \
    gss-ntlmssp \
    -y \
    && wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install dotnet-sdk-3.1 dotnet-sdk-6.0 -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /project/run.sh

ENTRYPOINT [ "/project/run.sh" ]

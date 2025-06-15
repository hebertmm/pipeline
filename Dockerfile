FROM alpine:3.19

LABEL maintainer="hebert@exemplo.com"
LABEL description="Imagem Jenkins Agent com WSO2 APICTL"

# Instalar utilitários necessários
RUN apk add --no-cache curl bash unzip ca-certificates

# Definir a versão do apictl desejada
ENV APICTL_VERSION=3.2.0

# Baixar e instalar o apictl
RUN curl -L -o apictl.tar.gz https://github.com/wso2/product-apim-tooling/releases/download/v4.4.1/apictl-4.4.1-linux-amd64.tar.gz && \
    tar -xvf apictl.tar.gz && \
    mv apictl/apictl /usr/local/bin/ && \
    chmod +x /usr/local/bin/apictl && \
    rm -rf apictl.zip apictl-${APICTL_VERSION}-linux-x64

RUN apk add --no-cache rsync openssh
    # Definir entrada padrão
CMD ["apictl", "version"]

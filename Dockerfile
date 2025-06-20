FROM registry.access.redhat.com/ubi9/ubi:9.6-1749542372

LABEL description="Imagem Jenkins Agent com WSO2 APICTL"

# Instalar utilitários necessários

# Definir a versão do apictl desejada
ENV APICTL_VERSION=4.4.1

# Baixar e instalar o apictl
RUN curl -L -o apictl.tar.gz https://github.com/wso2/product-apim-tooling/releases/download/v4.4.1/apictl-4.4.1-linux-amd64.tar.gz && \
    tar -xvf apictl.tar.gz && \
    mv apictl/apictl /usr/local/bin/ && \
    chmod +x /usr/local/bin/apictl && \
    rm -rf apictl.tar.gz apictl

# Definir entrada padrão
CMD ["apictl", "version"]

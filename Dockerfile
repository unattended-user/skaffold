FROM alpine

## Basic shell setup
RUN apk add --no-cache \
      bash \
      bash-completion
RUN echo source /etc/profile.d/bash_completion.sh > ~/.bashrc
CMD bash

## Install
RUN apk add --no-cache \
        curl \
        git

## Install kubectl
RUN curl -L -o /tmp/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install /tmp/kubectl /usr/local/bin/ && \
    rm /tmp/kubectl && \
    kubectl completion bash > /usr/share/bash-completion/completions/kubectl

## Install helm
RUN curl -L -o /tmp/helm.tar.gz "https://get.helm.sh/helm-$(git ls-remote --tags https://github.com/helm/helm.git | grep -E -o refs/tags/v[0-9]+\(.[0-9]+\)+$ | grep -E -o v[0-9]+\(.[0-9]+\)+$ | sort | tail -n 1)-linux-amd64.tar.gz" && \
    tar -zxvf /tmp/helm.tar.gz -C /tmp/ && \
    rm /tmp/helm.tar.gz && \
    install /tmp/linux-amd64/helm /usr/local/bin/ && \
    rm -R /tmp/linux-amd64 && \
    helm completion bash > /usr/share/bash-completion/completions/helm


## Install skaffold
RUN curl -L -o /tmp/skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
    install /tmp/skaffold /usr/local/bin/ && \
    rm /tmp/skaffold && \
    skaffold completion bash > /usr/share/bash-completion/completions/skaffold

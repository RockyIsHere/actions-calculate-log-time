FROM alpine:3.18.3

# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
ENV GITHUB_TOKEN=${GITHUB_TOKEN}
ENV GITHUB_REPOSITORY=${GITHUB_REPOSITORY}
ENV GITHUB_SHA=${GITHUB_SHA}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
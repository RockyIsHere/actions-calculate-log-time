FROM alpine:3.18.3

# Install required dependencies
RUN apk add --no-cache curl jq
RUN apk add coreutils

# Set environment variables
ENV GITHUB_TOKEN=${GITHUB_TOKEN}
ENV GITHUB_REPOSITORY=${GITHUB_REPOSITORY}
ENV GITHUB_SHA=${GITHUB_SHA}
ENV GITHUB_RUN_ID=${GITHUB_RUN_ID}

# Copy entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

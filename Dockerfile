FROM google/cloud-sdk:alpine
LABEL maintainer="Michael Lynch <michael@mtlynch.io>"

# Install Java 8 JRE (required for Firestore emulator).
RUN apk add --update --no-cache openjdk8-jre

# Install Firestore Emulator.
RUN gcloud components install cloud-firestore-emulator beta --quiet

COPY entrypoint.sh .

ENV PORT 8080
EXPOSE "$PORT"

ENV FIRESTORE_PROJECT_ID "dummy-firestore-id"

ENTRYPOINT ["./entrypoint.sh"]

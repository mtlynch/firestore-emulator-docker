# Google Cloud Firestore Emulator

[![CircleCI](https://circleci.com/gh/mtlynch/firestore-emulator-docker.svg?style=svg)](https://circleci.com/gh/mtlynch/firestore-emulator-docker) [![Docker Pulls](https://img.shields.io/docker/pulls/mtlynch/firestore-emulator.svg?maxAge=604800)](https://hub.docker.com/r/mtlynch/firestore-emulator/) [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](LICENSE)

A [Google Cloud Firestore Emulator](https://cloud.google.com/sdk/gcloud/reference/beta/emulators/firestore/) container image. The image creates a local, standalone Firestore emulator for testing Firestore-backed apps.

## Quickstart

To run the emulator in a standalone Docker container:

```bash
docker run \
  --name firestore-emulator \
  --env "FIRESTORE_PROJECT_ID=dummy-project-id" \
  --env "PORT=8080" \
  --publish 8080:8080 \
  mtlynch/firestore-emulator-docker
```

## Example docker-compose configuration

To run the emulator in a `docker-compose` configuration with your app, use the following example configuration for reference.

```yaml
version: "3.2"
services:
  firestore_emulator:
    image: mtlynch/firestore-emulator
    environment:
      - FIRESTORE_PROJECT_ID=dummy-project-id
      - PORT=8200
  app:
    image: your-app-image
    environment:
      - FIRESTORE_EMULATOR_HOST=firestore_emulator:8200
      - FIRESTORE_PROJECT_ID=dummy-project-id
  depends_on:
    - firestore_emulator
```

## Environment variables

* `FIRESTORE_PROJECT_ID`: This is the Google Cloud Project ID that the emulator uses.
  * This does not have to correspond to a real Google Cloud Project ID, although it can if you want it to.
  * Your application must set its firestore project ID value to match this environment variable.
  * default: `dummy-firestore-id`
* `PORT`: The port on which the firestore emulator listens for HTTP requests.
  * default: `8080`

## Connecting to the emulator

If you're using a standard Firestore client library and set the environment variable `FIRESTORE_EMULATOR_HOST`, then your app will connect to the emulator instead of the production Firestore URL. The variable specifies a host:port pair where the emulator is listening, for example `firestore_emulator:8080`.

Your app must also set the `FIRESTORE_PROJECT_ID` or explicitly set a Firestore project ID to match the `FIRESTORE_PROJECT_ID` you set in the emulator. The image's default project ID is `dummy-firestore-id`.

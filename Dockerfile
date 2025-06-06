# Use multi stage build to# minimize generated docker images size
# see: https://docs.docker.com/develop/develop-images/multistage-build/

# Step 1: create multi stage builder (about 800 MB)
FROM golang:1.24.4-alpine AS builder
LABEL stage=intermediate
RUN go version

RUN apt-get update -y; \
    apt-get install -y --no-cache ca-certificates; \
    update-ca-certificates;

WORKDIR /go/src/larmic/

COPY main.go go.mod go.sum /go/src/larmic/
COPY internal /go/src/larmic/internal
COPY api /go/src/larmic/api

RUN go mod download

RUN go test -v ./...

# CGO_ENABLED=0   -> Disable interoperate with C libraries -> speed up build time! Enable it, if dependencies use C libraries!
# GOOS=linux      -> compile to linux because scratch docker file is linux
# GOARCH=amd64    -> because, hmm, everthing works fine with 64 bit :)
# -a              -> force rebuilding of packages that are already up-to-date.
# -o app          -> force to build an executable app file (instead of default https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies)

ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG VERSION

RUN echo "I am running on $BUILDPLATFORM, building $VERSION for $TARGETPLATFORM"

# set version in open-api-3.yaml
RUN sed -i "s/\${VERSION}/$VERSION/" api/open-api-3.yaml

RUN if [ "$TARGETPLATFORM" = "linux/arm/v7" ] ; then \
        echo "I am building linux/arm/v7 with CGO_ENABLED=0 GOARCH=arm GOARM=7" ; \
        env CGO_ENABLED=0 GOARCH=arm GOARM=7 go build -a -o main . ; \
        echo "Build done" ; \
    fi

RUN if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then \
        echo "I am building linux/arm64 with CGO_ENABLED=0 GOARCH=arm64 GOARM=7" ; \
        env CGO_ENABLED=0 GOARCH=arm64 GOARM=7 go build -a -o main . ; \
        echo "Build done" ; \
    fi

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then \
        echo "I am building linux/amd64 with CGO_ENABLED=0 GOARCH=amd64" ; \
        env CGO_ENABLED=0 GOARCH=amd64 go build -a -o main . ; \
        echo "Build done" ; \
    fi

# Step 2: create minimal executable image (less than 10 MB)
FROM scratch
WORKDIR /root/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/src/larmic/main .

EXPOSE 8080
ENTRYPOINT ["./main"]

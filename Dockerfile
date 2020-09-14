FROM golang:1.14-alpine AS development

ENV PROJECT_PATH=/lora-gateway-bridge
ENV PATH=$PATH:$PROJECT_PATH/build
ENV CGO_ENABLED=0
ENV GO_EXTRA_BUILD_ARGS="-a -installsuffix cgo"

RUN apk add --no-cache ca-certificates make git bash

RUN mkdir -p $PROJECT_PATH
COPY . $PROJECT_PATH
WORKDIR $PROJECT_PATH

RUN make dev-requirements
RUN make

FROM alpine:3.11.2 AS production

RUN apk --no-cache add ca-certificates
COPY --from=development /lora-gateway-bridge/build/lora-gateway-bridge /usr/bin/lora-gateway-bridge
ENTRYPOINT ["/usr/bin/lora-gateway-bridge"]

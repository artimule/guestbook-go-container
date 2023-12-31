# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Build stage
FROM golang:1.10.0 AS builder

RUN go get github.com/codegangsta/negroni \
           github.com/gorilla/mux \
           github.com/xyproto/simpleredis/v2

WORKDIR /app
ADD ./main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Final image
FROM alpine

WORKDIR /app

COPY --from=builder /app/main .
COPY ./public/index.html public/index.html
COPY ./public/script.js public/script.js
COPY ./public/style.css public/style.css

# Install Redis
RUN apk update && apk add redis

# Expose ports
EXPOSE 6379
EXPOSE 3000

# Start Redis and your Go application
CMD ["sh", "-c", "redis-server & ./main"]

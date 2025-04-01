# Use a starting base image that has rust and rust dependencies baked in already.
FROM rust:latest AS builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Cargo files first to leverage caching
COPY Cargo.toml Cargo.lock ./
COPY . .
RUN cargo build --release

# We want the final image to be as small as possible.
FROM debian:bookworm-slim

# Add bash so we can poke around the container's FS.
# RUN apk add --no-cache bash
RUN apt update && apt install -y bash

WORKDIR /usr/src/app

# Copy over just the source code.
COPY --from=builder /usr/src/app /usr/src/app

# Set the executable entrypoint
CMD ["./target/release/webserver"]

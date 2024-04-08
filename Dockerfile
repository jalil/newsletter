FROM rust:1.77.1-slim AS builder
WORKDIR /app

RUN apt update  && apt install lld clang -y
COPY . .

ENV SQLX_OFFLINE true
RUN cargo build --release 


# Runtime stage
FROM debian:bullseye-slim AS runtime
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/newsletter newsletter
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["./target/release/newsletter"]
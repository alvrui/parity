FROM debian:latest
RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get -y install curl
#RUN apt-get -y install cmake pkg-config libssl-dev git gcc build-essential clang libclang-dev
CMD useradd -m substrate
CMD usermod -aG sudo substrate
CMD su substrate
WORKDIR /home/substrate
RUN export PATH="$HOME/.cargo/bin:$PATH"
#RUN curl http://getsubstrate.io -sSf | bash
#RUN curl https://getsubstrate.io -sSf | bash -s -- --fast
#issue4978
RUN curl https://getsubstrate.io -sSf | bash -s -- --fast
RUN export PATH="$HOME/.cargo/bin:$PATH"
RUN rustup install nightly-2020-02-17
RUN rustup target add wasm32-unknown-unknown --toolchain nightly-2020-02-17
RUN cargo +nightly-2020-02-17 install --force --git https://github.com/paritytech/substrate subkey
#RUN cargo install --force --git https://github.com/paritytech/substrate subkey
#ENV PATH="$HOME/.cargo/bin:$PATH"
RUN git clone https://github.com/paritytech/substrate
#WORKDIR /home/substrate/substrate
RUN cargo build --release
#FROM lvrrz/substrate-ok:latest

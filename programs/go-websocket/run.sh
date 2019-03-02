set -Eeuxo pipefail

unset RUST_LOG

cd "$(dirname ${BASH_SOURCE[0]})"

GOOS=js GOARCH=wasm go1.12beta1 build -o go-websocket.wasm

cd ../../wasabi
cargo +nightly build --release

cd ..
RUST_BACKTRACE=full ./wasabi/target/release/wasabi \
    ./programs/go-websocket/go-websocket.wasm

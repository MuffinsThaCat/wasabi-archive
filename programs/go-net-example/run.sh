set -Eeuxo pipefail

unset RUST_LOG

cd "$(dirname ${BASH_SOURCE[0]})"

GOOS=js GOARCH=wasm go1.12beta1 build -o go-net-example.wasm

cd ../../wasabi
cargo +nightly build --release

cd ..
RUST_BACKTRACE=full ./wasabi/target/release/wasabi \
    ./programs/go-net-example/go-net-example.wasm

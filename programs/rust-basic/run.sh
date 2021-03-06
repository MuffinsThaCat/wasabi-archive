set -o xtrace
set -o pipefail
set -e
cd "$(dirname ${BASH_SOURCE[0]})"

cd wasabi
cargo +nightly build --release

cd ../programs/rust-basic
cargo +nightly build --target wasm32-unknown-unknown --release
wasm-gc target/wasm32-unknown-unknown/release/rust_basic.wasm

cd ../..
RUST_BACKTRACE=full ./wasabi/target/release/wasabi --invoke=main \
    ./programs/rust-basic/target/wasm32-unknown-unknown/release/rust_basic.wasm

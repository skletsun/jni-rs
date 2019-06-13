#!/usr/bin/env bash

# Fail immediately in case of errors and/or unset variables
set -eu -o pipefail

# Echo commands so that the progress can be seen in CI server logs.
set -x

# Install clippy and rustfmt.
rustup component add clippy
rustup component add rustfmt
rustfmt -V
cargo clippy -V

echo 'Performing checks over the rust code'
# Check the formatting.
cargo fmt --all -- --check

#JAVA_HOME="${JAVA_HOME:-$(java -XshowSettings:properties -version \

# Run clippy static analysis.
cargo clippy --all --tests --all-features -- -D warnings

#JAVA_HOME="$(java -XshowSettings:properties -version \
#    2>&1 > /dev/null |\
#    grep 'java.home' |\
#    awk '{print $3}')"
#LIBJVM_PATH="$(find -L ${JAVA_HOME} -type f -name libjvm.* | xargs -n1 dirname)"
#
#export LD_LIBRARY_PATH="${LIBJVM_PATH}"

# Run all tests
cargo test --features=backtrace,invocation

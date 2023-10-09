./config

bazel build //xla/...

bazel run :refresh_compile_commands

mkdir -p build
mv compile_commands.json build/

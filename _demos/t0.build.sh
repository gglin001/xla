###############################################################################

python configure.py -h

###############################################################################

args=(
  --backend CPU
  --os MACOS
  --host_compiler CLANG
  --python_bin_path $(which python)
  --clang_path $(which clang)
  --lld_path $(which ld64.lld)
)
python configure.py "${args[@]}"

###############################################################################

# https://github.com/bazelbuild/bazelisk

bazelisk aquery "//xla/examples/..."
bazelisk query "//xla/examples/..."
bazelisk query "//xla/service/spmd/shardy/..."

###############################################################################

# demo
bazelisk build //xla/examples/axpy:stablehlo_compile_test

# all
bazelisk build //xla/...

bazelisk run :refresh_compile_commands

###############################################################################

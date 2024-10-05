###############################################################################

# check `third_party/llvm/workspace.bzl` for `LLVM_COMMIT`
ln -s /Users/allen/repos/_compiler/llvm-project-full $PWD/llvm-project-full

DIR=$PWD/llvm-project-full && PPWD=$PWD
pushd $DIR
# WORKSPACE
cat >WORKSPACE <<EOF
workspace(name = "llvm-raw")
EOF
# BUILD.bazel
cat >BUILD.bazel <<EOF
EOF
popd

DIR=$PWD/llvm-project-full && PPWD=$PWD
pushd $DIR
# patch
find $PPWD/third_party/llvm/*.patch -print0 | xargs -0 -I{} git apply {}
popd

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

# cat >>xla_configure.bazelrc <<EOF
# build --repo_env HERMETIC_PYTHON_VERSION=3.12
# EOF

###############################################################################

# https://github.com/bazelbuild/bazelisk

bazelisk info

bazelisk query "//xla/..."
bazelisk query "//xla/examples/..."
bazelisk query "//xla/service/spmd/shardy/..."

bazelisk aquery "//xla/examples/..."

###############################################################################

# demo
bazelisk build //xla/examples/axpy:stablehlo_compile_test

# all
bazelisk build //xla/...

bazelisk run :refresh_compile_commands

###############################################################################

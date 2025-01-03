"""Provides the repository macro to import LLVM."""

_ = """
load("//third_party:repo.bzl", "tf_http_archive")

def repo(name):
    "Imports LLVM."
    LLVM_COMMIT = "f739aa4004165dc64d3a1f418d5ad3c84886f01a"
    LLVM_SHA256 = "85da134e7ba044ef50ebc009d1a57a87fb0e2db208a04650ef2fe564e9564aa7"

    tf_http_archive(
        name = name,
        sha256 = LLVM_SHA256,
        strip_prefix = "llvm-project-{commit}".format(commit = LLVM_COMMIT),
        urls = [
            "https://storage.googleapis.com/mirror.tensorflow.org/github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT),
            "https://github.com/llvm/llvm-project/archive/{commit}.tar.gz".format(commit = LLVM_COMMIT),
        ],
        build_file = "//third_party/llvm:llvm.BUILD",
        patch_file = [
            "//third_party/llvm:generated.patch",  # Autogenerated, don't remove.
            "//third_party/llvm:build.patch",
            "//third_party/llvm:mathextras.patch",
            "//third_party/llvm:toolchains.patch",
            "//third_party/llvm:zstd.patch",
        ],
        link_files = {"//third_party/llvm:run_lit.sh": "mlir/run_lit.sh"},
    )
"""

load("@bazel_tools//tools/build_defs/repo:local.bzl", "local_repository")
local_path = "llvm-project-full"
def repo(name):
    local_repository(name = name, path = local_path)

#!/usr/bin/env sh
set -eu

# 从任何工作目录执行：sh /path/to/slotgame/proto/gen.sh
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OUT_DIR="$SCRIPT_DIR/../game/pb"

command -v protoc >/dev/null 2>&1 || {
  echo "错误：找不到 protoc，请先安装并加入 PATH。" >&2
  exit 1
}
command -v protoc-gen-go >/dev/null 2>&1 || {
  echo "错误：找不到 protoc-gen-go，请先安装并加入 PATH。" >&2
  exit 1
}

mkdir -p "$OUT_DIR"
set -- "$SCRIPT_DIR"/*.proto
if [ ! -f "$1" ]; then
  echo "错误：协议目录中没有 .proto 文件。" >&2
  exit 1
fi

# 按 go_package 输出；module 去掉 server/pb 前缀，支持玩法独立子包。
# 此脚本不自动删除输出目录，避免误删手写文件。
protoc --proto_path="$SCRIPT_DIR" \
  --go_out="$OUT_DIR" \
  --go_opt=module=server/pb \
  "$@"

echo "生成完成：$OUT_DIR"

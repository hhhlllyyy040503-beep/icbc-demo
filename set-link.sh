#!/usr/bin/env bash
# 换跳转目标：./set-link.sh <新的分享链接>
# 只改 latest.json，不动 index.html。
set -euo pipefail
cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
  echo "用法: ./set-link.sh https://xxxx.sg2.agentos-app.run" >&2
  exit 1
fi

URL="$1"
case "$URL" in
  http://*|https://*) ;;
  *) echo "链接必须以 http:// 或 https:// 开头" >&2; exit 1 ;;
esac

python3 - "$URL" <<'PY'
import json, sys, datetime, pathlib
url = sys.argv[1].rstrip("/")
p = pathlib.Path("latest.json")
data = json.loads(p.read_text(encoding="utf-8")) if p.exists() else {}
old = data.get("url", "")
data["url"] = url
data["updated"] = datetime.date.today().isoformat()
data.setdefault("_comment",
    "改这一个文件就能换跳转目标，不需要动 index.html。改完 commit，GitHub Pages 约 1 分钟内生效。")
p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(f"旧目标: {old or '(空)'}")
print(f"新目标: {url}")
PY

echo
echo "接下来提交并推送："
echo "  git add latest.json && git commit -m \"chore: 更新演示链接\" && git push"
echo "GitHub Pages 大约 1 分钟后生效，固定入口地址不变。"

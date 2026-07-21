#!/bin/bash
cd "$(dirname "$0")"
FA="29795702724"
FL="29795710744"
while true; do
  t=$(date +%H:%M)
  fa_status=$(gh run view "$FA" --json status,conclusion -q '.status + " " + .conclusion' 2>/dev/null)
  fl_status=$(gh run view "$FL" --json status,conclusion -q '.status + " " + .conclusion' 2>/dev/null)
  echo "$t  full-apps: $fa_status  lite: $fl_status"
  echo "$fa_status" | grep -q "completed" || { sleep 180; continue; }
  echo "$fl_status" | grep -q "completed" || { sleep 180; continue; }
  break
done
echo "=== DONE ==="
gh run view "$FA" --json status,conclusion,headBranch -q '"\(.headBranch): \(.status) \(.conclusion)"' 2>/dev/null
gh run view "$FL" --json status,conclusion,headBranch -q '"\(.headBranch): \(.status) \(.conclusion)"' 2>/dev/null

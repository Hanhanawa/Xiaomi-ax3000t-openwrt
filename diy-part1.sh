#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

set -e

echo "========================================"
echo " Preparing OpenWrt feeds"
echo "========================================"

# ---------------------------------------------------------
# Remove PassWall2 feed only
# Do NOT remove helloworld or other feeds.
# ---------------------------------------------------------
if grep -q 'passwall2' feeds.conf.default 2>/dev/null; then
    echo "[INFO] Removing PassWall2 feed..."
    sed -i '/passwall2/d' feeds.conf.default
fi

# ---------------------------------------------------------
# Add OpenClash feed
# Avoid duplicate entries.
# ---------------------------------------------------------
if grep -q '^src-git openclash ' feeds.conf.default; then
    echo "[INFO] OpenClash feed already exists."
else
    echo "[INFO] Adding OpenClash feed..."
    echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default
fi

echo
echo "========================================"
echo " Current feeds"
echo "========================================"

cat feeds.conf.default

echo
echo "========================================"
echo " OpenClash feed"
echo "========================================"

grep '^src-git openclash ' feeds.conf.default || true

echo
echo "========================================"
echo " diy-part1.sh completed"
echo "========================================"

#!/usr/bin/env python3
"""Update the LUBAN Code Cask from its latest GitHub release."""

from __future__ import annotations

import pathlib
import re
import urllib.request


REPOSITORY = "agent-dance/luban"
API = f"https://api.github.com/repos/{REPOSITORY}/releases/latest"
RELEASES = f"https://github.com/{REPOSITORY}/releases/download"
ASSETS = {
    "darwin_arm64": "luban-code_Darwin_arm64.tar.gz",
    "darwin_x86_64": "luban-code_Darwin_x86_64.tar.gz",
    "linux_arm64": "luban-code_Linux_arm64.tar.gz",
    "linux_x86_64": "luban-code_Linux_x86_64.tar.gz",
}


def download(url: str) -> bytes:
    request = urllib.request.Request(
        url,
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "agent-dance-homebrew-tap",
            "X-GitHub-Api-Version": "2022-11-28",
        },
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read()


def latest_tag() -> str:
    import json

    payload = json.loads(download(API))
    tag = payload.get("tag_name", "")
    if not re.fullmatch(r"v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)", tag):
        raise RuntimeError(f"latest release has invalid stable tag: {tag!r}")
    return tag


def checksums(tag: str) -> dict[str, str]:
    text = download(f"{RELEASES}/{tag}/checksums.txt").decode("ascii")
    found: dict[str, str] = {}
    for line in text.splitlines():
        match = re.fullmatch(r"([0-9a-fA-F]{64})\s+\*?(.+)", line)
        if match:
            found[match.group(2)] = match.group(1).lower()
    missing = sorted(set(ASSETS.values()) - found.keys())
    if missing:
        raise RuntimeError(f"checksums.txt is missing required assets: {missing}")
    return found


def render(tag: str, sums: dict[str, str]) -> str:
    version = tag.removeprefix("v")

    def platform_block(os_name: str, arch: str, key: str) -> str:
        asset = ASSETS[key]
        return f'''    on_{arch} do
      sha256 "{sums[asset]}"
      url "{RELEASES}/v#{{version}}/{asset}"
    end'''

    return f'''cask "luban-code" do
  version "{version}"

  on_macos do
{platform_block("macos", "arm", "darwin_arm64")}

{platform_block("macos", "intel", "darwin_x86_64")}
  end

  on_linux do
{platform_block("linux", "arm", "linux_arm64")}

{platform_block("linux", "intel", "linux_x86_64")}
  end

  name "LUBAN Code"
  desc "Agentic coding CLI with repository tools and multiple model providers"
  homepage "https://github.com/{REPOSITORY}"

  binary "luban-code"
end
'''


def main() -> None:
    tag = latest_tag()
    destination = pathlib.Path(__file__).resolve().parents[1] / "Casks" / "luban-code.rb"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(render(tag, checksums(tag)), encoding="utf-8")
    print(f"updated {destination} for {tag}")


if __name__ == "__main__":
    main()

cask "luban-code" do
  version "0.1.0"

  on_macos do
    on_arm do
      sha256 "b854e7676298929151f1c589b580c8f79a1b1dd879fdda5bad265a03a3be2830"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "e5372e388692f9c782ca2794fa55755355d598a6282bc52562e47d4cf0c9b809"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_x86_64.tar.gz"
    end
  end

  on_linux do
    on_arm do
      sha256 "88f9205fea43a5823e3d57a2e98655f0bdd398736534dcc503d0b619a0d8842a"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "e79ba111ca17ee0c1acd690d9487209d353a85076a3b6253da02abfc9797d406"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Linux_x86_64.tar.gz"
    end
  end

  name "LUBAN Code"
  desc "Agentic coding CLI with repository tools and multiple model providers"
  homepage "https://github.com/agent-dance/luban"

  binary "luban-code"

  postflight do
    if OS.mac?
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{staged_path}/luban-code"]
    end
  end
end

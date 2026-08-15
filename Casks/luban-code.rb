cask "luban-code" do
  version "0.1.1"

  on_macos do
    on_arm do
      sha256 "960aa97337a8d2c6d3e7306832d9a655318013d9c1e7c93463c7155122b6d628"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "024c0ce624c3bbd143bf7e85fdc3ab5b39ac33b744f4d6b38fdd38dd3ce0b74c"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_x86_64.tar.gz"
    end
  end

  on_linux do
    on_arm do
      sha256 "4c7396ad127b7da9da5261b69a998bbfacf2708766cf02a7065e32fb69a4c3d0"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "5f9b57bfed3f97ebe90e26e296c487ff31f5d54edce8c7461b6ea47ca669af6a"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Linux_x86_64.tar.gz"
    end
  end

  name "LUBAN Code"
  desc "Agentic coding CLI with repository tools and multiple model providers"
  homepage "https://github.com/agent-dance/luban"

  binary "luban"

  postflight do
    if OS.mac?
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{staged_path}"]
    end
  end
end

cask "luban-code" do
  version "0.2.0"

  on_macos do
    on_arm do
      sha256 "260156cf873644b0edc70db702bb70ac9544a6fcf440751bb318d53a81bf872e"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "24179a4208eaf5f20dc3aec25eb66332c409e89f5389a9e06d56febf52b35f3e"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Darwin_x86_64.tar.gz"
    end
  end

  on_linux do
    on_arm do
      sha256 "b819ccd9f1fa7c422d65a632329490832edb4886b04af427d764704d306a7254"
      url "https://github.com/agent-dance/luban/releases/download/v#{version}/luban-code_Linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "dec03e094ae4d8de5c33719ebd64920ab11c035b24ca8d62d30d9894dca8744e"
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

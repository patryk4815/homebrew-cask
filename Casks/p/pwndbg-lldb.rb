cask "pwndbg-lldb" do
  arch arm: "arm64", intel: "amd64"

  version "2025.01.20"
  sha256 arm:   "474ff77d3994d453de5ff2481852dadd337082ce294816d5c794baa697c87e97",
         intel: "b0d84f95b5fe3649e8a95ff1030ec91716a91bb3af18ad0e302d866941fa3fe7"

  url "https://github.com/pwndbg/pwndbg/releases/download/#{version}/pwndbg-lldb_#{version}_macos_#{arch}-portable.tar.xz"
  name "pwndbg-lldb"
  desc "Exploit Development and Reverse Engineering with LLDB Made Easy"
  homepage "https://github.com/pwndbg/pwndbg"

  livecheck do
    url :url
    strategy :github_latest
  end

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  pwndbg_shimscript = "#{staged_path}/pwndbg.wrapper.sh"
  binary pwndbg_shimscript, target: "pwndbg-lldb"

  preflight do
    File.write pwndbg_shimscript, <<~EOS
      #!/bin/sh
      exec '#{staged_path}/pwndbg/bin/pwndbg-lldb' "$@"
    EOS
  end

  zap trash: "~/.cache/pwndbg"
end

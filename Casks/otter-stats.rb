cask "otter-stats" do
  version "0.1.1"
  sha256 "d00bbcbe1d7a9ef9e08f882c5c62bd59d0b1e596bef690fe7c6c8da24c5aa146"

  url "https://github.com/chris-wozniczek/otter-stats/releases/download/v#{version}/OtterStats.zip"
  name "Otter Stats"
  desc "Menu bar usage and cost stats for Devin CLI and Devin Desktop"
  homepage "https://github.com/chris-wozniczek/otter-stats"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "OtterStats.app"

  # The app is ad-hoc signed (no Apple Developer ID yet); drop the quarantine
  # flag so Gatekeeper does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/OtterStats.app"],
        must_succeed: false
  end

  uninstall quit: "dev.otterswarm.otter-stats"

  zap trash: [
    "~/Library/Application Support/OtterStats",
    "~/Library/Preferences/dev.otterswarm.otter-stats.plist",
  ]
end

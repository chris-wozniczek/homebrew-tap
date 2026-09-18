cask "otter-stats" do
  version "0.2.0"
  sha256 "a4f94683ed220c54c56a83e823854ccc44550d320396d8dfe8d12554a52869a5"

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

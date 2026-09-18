cask "otter-stats" do
  version "0.1.0"
  sha256 "427b3c1d84031351e37bc388af285b7850e3f98a36183f70ae57baac32d3d311"

  url "https://github.com/chris-wozniczek/otter-stats/releases/download/v#{version}/OtterStats.zip"
  name "Otter Stats"
  desc "Menu bar usage and cost stats for Devin CLI and Devin Desktop"
  homepage "https://github.com/chris-wozniczek/otter-stats"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "OtterStats.app"

  # The app is ad-hoc signed (no Apple Developer ID yet); drop the quarantine
  # flag so Gatekeeper does not block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OtterStats.app"],
                   must_succeed: false
  end

  uninstall quit: "dev.otterswarm.otter-stats"

  zap trash: [
    "~/Library/Application Support/OtterStats",
    "~/Library/Preferences/dev.otterswarm.otter-stats.plist",
  ]
end

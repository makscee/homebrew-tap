class Claudev < Formula
  desc "Pool OAuth wrapper around the claude CLI"
  homepage "https://github.com/makscee/claudev"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/makscee/claudev/releases/download/v0.3.1/claudev-darwin-amd64"
      sha256 "7701bbd4bb55c1bf46ab9e972638984649958f56d95880f4db7e6e31c185c16a"
    else
      url "https://github.com/makscee/claudev/releases/download/v0.3.1/claudev-darwin-arm64"
      sha256 "bfc4b8ca87bde9c081606abde988edab71dff4b978c748e234ce6312e732a15e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/makscee/claudev/releases/download/v0.3.1/claudev-linux-amd64"
      sha256 "bc15880810bca378616fd88762b5cafcd2960427ab16e33340822837cb6fe63d"
    else
      url "https://github.com/makscee/claudev/releases/download/v0.3.1/claudev-linux-arm64"
      sha256 "7f00049e61364873c23ce82946b81ba1c9357068a3f11ea10a20c863b5f28ad0"
    end
  end

  def install
    bin.install Dir["*"].first => "claudev"
  end

  test do
    assert_predicate bin/"claudev", :executable?
    system bin/"claudev", "--version"
  end
end

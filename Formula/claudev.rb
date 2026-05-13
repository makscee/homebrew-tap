class Claudev < Formula
  desc "Pool OAuth wrapper around the claude CLI"
  homepage "https://github.com/makscee/claudev"
  head "https://github.com/makscee/claudev.git", branch: "master"

  def install
    bin.install "claudev"
  end

  test do
    assert_predicate bin/"claudev", :executable?
  end
end

class VoidOs < Formula
  desc "Local daemon + vault for Claude Code workflows"
  homepage "https://github.com/makscee/void-os"
  head "https://github.com/makscee/void-os.git", branch: "main"

  depends_on "bun"
  depends_on "makscee/tap/claudev"

  def install
    ENV.prepend_path "PATH", Formula["bun"].opt_bin
    cd "daemon" do
      system "bun", "install", "--frozen-lockfile"
    end
    # Plugin build is optional — skip cleanly if the package isn't real yet.
    if File.exist?("plugin/package.json")
      cd "plugin" do
        system "bun", "install", "--frozen-lockfile"
        system "bun", "run", "build" if plugin_build_script?
      end
    end
    # Explicit allowlist — keeps node_modules nested under daemon/, skips
    # repo dotfiles, and surfaces any new top-level dir as a deliberate change.
    libexec.install "bin", "cli", "daemon", "vault-starter"
    libexec.install "plugin" if File.directory?("plugin")
    (bin/"void-os").write_env_script libexec/"bin/void-os",
                                     VOID_OS_PREFIX: libexec.to_s,
                                     PATH:           "#{Formula["bun"].opt_bin}:$PATH"
  end

  def plugin_build_script?
    return false unless File.exist?("plugin/package.json")

    pkg = JSON.parse(File.read("plugin/package.json"))
    pkg.dig("scripts", "build") ? true : false
  end

  service do
    run [opt_bin/"void-os", "daemon"]
    keep_alive crashed: true
    log_path        var/"log/void-os.log"
    error_log_path  var/"log/void-os.err.log"
    # HOME and VOID_HOME are explicit so the daemon resolves the same vault dir
    # the user provisioned via `void-os init`. Without this, `brew services`
    # under launchd may inherit HOME=/var/root and split-brain silently.
    environment_variables PATH:      std_service_path_env,
                          HOME:      Dir.home,
                          VOID_HOME: "#{Dir.home}/void"
  end

  test do
    system bin/"void-os", "init", "--dry-run", "--home", testpath/"vault"
  end
end

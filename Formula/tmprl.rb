class Tmprl < Formula
  desc "A keyboard-driven terminal client for Temporal"
  homepage "https://github.com/arisros/tmprl"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.0/tmprl-aarch64-apple-darwin.tar.xz"
      sha256 "5304d6f14b8bd07ae6435e4a1d73ec457994c5a35e4099dd046ba9411ce674d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.0/tmprl-x86_64-apple-darwin.tar.xz"
      sha256 "bf9968cd79f12d6b7be2d77f6af2f8cf5234395be7a62f31d2729df446e4db1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.0/tmprl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e170e32f37cedb102cd6b6cadc1bd8ed8a2dafb137d13cb90d82eb995f27beeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.0/tmprl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "599c025ca0dac29aea8c39157ce81a34cf184591789bec6e083faecd3a00b55d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tmprl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tmprl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tmprl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tmprl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

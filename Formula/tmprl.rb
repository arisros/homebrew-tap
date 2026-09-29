class Tmprl < Formula
  desc "A keyboard-driven terminal client for Temporal"
  homepage "https://github.com/arisros/tmprl"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.3/tmprl-aarch64-apple-darwin.tar.xz"
      sha256 "5f3568a64556262913bad1be24b41dc0c217a782ce4078a6a30fd6b3213f58fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.3/tmprl-x86_64-apple-darwin.tar.xz"
      sha256 "42d578d4deb7bc7c1ea9a4bc305bf987ee3f9eeab87538a3c5faf1b7f9711cdb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.3/tmprl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d9bd2d633e00ddb4d5d5a368052c6bd50bf727baaf59497af791ea7d8544475"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.3/tmprl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ae2c436d88be54c6f071f90e69201006d085921475e174a6cf86f663ab61037"
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

class Tmprl < Formula
  desc "A keyboard-driven terminal client for Temporal"
  homepage "https://github.com/arisros/tmprl"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.5/tmprl-aarch64-apple-darwin.tar.xz"
      sha256 "6ae7502b6c5433c6d62853ec89220f66a6970560845dfbeaa65cee6f2b363fc0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.5/tmprl-x86_64-apple-darwin.tar.xz"
      sha256 "7df891c01d359bd811b37f6d8dd6824c23e1b2c615995184ed8faaa9a2e17c04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.5/tmprl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "359b127aa41185b192f64184f06124970b1561b03df39e0793854dc98ff515c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.5/tmprl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fcfe830643d53d53a726973e1d357b2d8f22837549ace0afbe5bfdc802d3550f"
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

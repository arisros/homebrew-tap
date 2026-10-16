class Tmprl < Formula
  desc "A keyboard-driven terminal client for Temporal"
  homepage "https://github.com/arisros/tmprl"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.2/tmprl-aarch64-apple-darwin.tar.xz"
      sha256 "a1e66b7fbddbd884d15cc5a9982a12e7e6396c0a35692bd6f557db5d7c3f2d3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.2/tmprl-x86_64-apple-darwin.tar.xz"
      sha256 "ef5d15b5178d3b6d166aa495b17fbfb9f66478fdebff4de638ba10798bddf7f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.2/tmprl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4832e81d47f27f5395c6b6103aaca6a84a97386fd90ee31db55335a9b70f8239"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.4.2/tmprl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb0625bd9fe20cca860ae2dd9b10341cf48330de672fc47b15135a35d1c600aa"
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

class Tmprl < Formula
  desc "A keyboard-driven terminal client for Temporal"
  homepage "https://github.com/arisros/tmprl"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.4/tmprl-aarch64-apple-darwin.tar.xz"
      sha256 "701bf2926abf75280ccc6a174c427997ecb152fd631d8acecc7dd913c2db71dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.4/tmprl-x86_64-apple-darwin.tar.xz"
      sha256 "125c435f4c712093a9c64526c5a96d3cd854d95daeee3e90e15cdd3cfac7883a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.4/tmprl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1b7d9e7a9e6693dc261025487f05799c1a15c2243fa6361145d7d9ab57c3d2db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/arisros/tmprl/releases/download/v0.1.4/tmprl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7e0fbb7d3f711edb0b34f688353d133f9cb3f71a59550edfab2c4fbc0d096d57"
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

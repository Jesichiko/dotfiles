#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_message() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

detect_os() {
  if command_exists apt-get; then
    echo "debian"
  elif command_exists pacman; then
    echo "arch"
  else
    echo "unknown"
  fi
}

install_base_dependencies() {
  OS=$(detect_os)

  print_message "Installing base dependencies for $OS..."

  case $OS in
  debian)
    sudo apt update
    sudo apt install -y curl wget zsh fzf
    ;;
  arch)
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm curl wget zsh fzf
    ;;
  *)
    print_error "Unsupported OS. This script only supports Debian/Ubuntu and Arch Linux."
    exit 1
    ;;
  esac

  print_success "Base dependencies installed successfully!"
}

install_nodejs() {
  print_message "Installing Node.js and npm..."

  if command_exists node; then
    node_version=$(node -v)
    print_warning "Node.js $node_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
    ;;
  arch)
    sudo pacman -S --noconfirm nodejs npm
    ;;
  *)
    print_error "Cannot install Node.js. Unsupported OS."
    ;;
  esac

  print_success "Node.js and npm installed successfully!"
}

install_yarn() {
  print_message "Installing Yarn..."

  if command_exists yarn; then
    yarn_version=$(yarn -v)
    print_warning "Yarn $yarn_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    # Make sure nodejs is installed first
    if ! command_exists node; then
      print_error "Node.js must be installed before Yarn. Please install Node.js first."
      return
    fi
    sudo npm install -g yarn
    ;;
  arch)
    sudo pacman -S --noconfirm yarn
    ;;
  *)
    print_error "Cannot install Yarn. Unsupported OS."
    ;;
  esac

  print_success "Yarn installed successfully!"
}

install_treesitter() {
  print_message "Installing Tree-sitter CLI..."

  if command_exists tree-sitter; then
    print_warning "Tree-sitter CLI is already installed, skipping..."
    return
  fi

  # Install using npm
  if command_exists npm; then
    sudo npm install -g tree-sitter-cli
  else
    print_error "npm is required to install Tree-sitter CLI. Please install Node.js first."
    return
  fi

  print_success "Tree-sitter CLI installed successfully!"
}

install_rust() {
  print_message "Installing Rust and Cargo..."

  if command_exists rustc && command_exists cargo; then
    rust_version=$(rustc --version | cut -d ' ' -f 2)
    print_warning "Rust $rust_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    ;;
  arch)
    sudo pacman -S --noconfirm rustup
    rustup default stable
    ;;
  *)
    print_error "Cannot install Rust. Unsupported OS."
    ;;
  esac

  print_success "Rust and Cargo installed successfully!"
}

install_luarocks() {
  print_message "Installing LuaRocks..."

  if command_exists luarocks; then
    luarocks_version=$(luarocks --version | head -n 1)
    print_warning "$luarocks_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    sudo apt install -y luarocks
    ;;
  arch)
    sudo pacman -S --noconfirm luarocks
    ;;
  *)
    print_error "Cannot install LuaRocks. Unsupported OS."
    ;;
  esac

  print_success "LuaRocks installed successfully!"
}

install_perl() {
  print_message "Installing Perl..."

  if command_exists perl; then
    perl_version=$(perl --version | grep -oP 'This is perl \K\d+\.\d+\.\d+')
    print_warning "Perl $perl_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    sudo apt install -y perl
    ;;
  arch)
    sudo pacman -S --noconfirm perl
    ;;
  *)
    print_error "Cannot install Perl. Unsupported OS."
    ;;
  esac

  print_success "Perl installed successfully!"
}

install_php_composer() {
  print_message "Installing PHP and Composer..."

  OS=$(detect_os)

  if ! command_exists php; then
    case $OS in
    debian)
      sudo apt install -y php php-cli php-mbstring php-xml php-curl
      ;;
    arch)
      sudo pacman -S --noconfirm php
      ;;
    *)
      print_error "Cannot install PHP. Unsupported OS."
      return
      ;;
    esac
    print_success "PHP installed successfully!"
  else
    php_version=$(php -v | grep -oP 'PHP \K\d+\.\d+\.\d+')
    print_warning "PHP $php_version is already installed, skipping..."
  fi

  if ! command_exists composer; then
    case $OS in
    debian | arch)
      EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

      if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        print_error "Composer installer checksum verification failed."
        rm composer-setup.php
        return
      fi

      php composer-setup.php --quiet
      rm composer-setup.php
      sudo mv composer.phar /usr/local/bin/composer
      ;;
    *)
      print_error "Cannot install Composer. Unsupported OS."
      return
      ;;
    esac
    print_success "Composer installed successfully!"
  else
    composer_version=$(composer --version | grep -oP 'version \K\d+\.\d+\.\d+')
    print_warning "Composer $composer_version is already installed, skipping..."
  fi
}

install_oh_my_posh() {
  print_message "Installing Oh My Posh..."

  if command_exists oh-my-posh; then
    print_warning "Oh My Posh is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian | arch)
    curl -s https://ohmyposh.dev/install.sh | bash -s
    ;;
  *)
    print_error "Cannot install Oh My Posh. Unsupported OS."
    ;;
  esac

  print_success "Oh My Posh installed successfully!"
}

install_zinit() {
  print_message "Installing Zinit..."

  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  if [ -d "$ZINIT_HOME" ]; then
    print_warning "Zinit is already installed, skipping..."
    return
  fi

  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

  print_success "Zinit installed successfully!"
}

install_neovim() {
  print_message "Installing Neovim..."

  if command_exists nvim; then
    current_version=$(nvim --version | head -n 1 | cut -d ' ' -f 2)
    print_warning "Neovim $current_version is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    ;;
  arch)
    sudo pacman -S --noconfirm neovim
    ;;
  *)
    print_error "Cannot install Neovim. Unsupported OS."
    ;;
  esac

  print_success "Neovim installed successfully!"
}

install_zoxide() {
  print_message "Installing Zoxide..."

  if command_exists zoxide; then
    print_warning "Zoxide is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    ;;
  arch)
    sudo pacman -S --noconfirm zoxide
    ;;
  *)
    print_error "Cannot install Zoxide. Unsupported OS."
    ;;
  esac

  print_success "Zoxide installed successfully!"
}

install_fortune() {
  print_message "Installing fortune (optional for Discord presence)..."

  if command_exists fortune; then
    print_warning "Fortune is already installed, skipping..."
    return
  fi

  OS=$(detect_os)

  case $OS in
  debian)
    sudo apt install -y fortune-mod
    ;;
  arch)
    sudo pacman -S --noconfirm fortune-mod
    ;;
  *)
    print_error "Cannot install Fortune. Unsupported OS."
    ;;
  esac

  print_success "Fortune installed successfully!"
}

install_ghostty() {
  print_message "Installing Ghostty terminal is optional..."
  print_message "Ghostty can be downloaded from: https://ghostty.org/download"
  print_message "Follow the instructions on the website to install it for your OS."
}

main() {
  print_message "Starting dotfiles dependencies installation..."

  OS=$(detect_os)
  if [ "$OS" = "unknown" ]; then
    print_error "This script only supports Debian/Ubuntu and Arch Linux."
    exit 1
  fi

  install_base_dependencies
  install_nodejs
  install_yarn
  install_treesitter
  install_rust
  install_luarocks
  install_perl
  install_php_composer
  install_oh_my_posh
  install_zinit
  install_neovim
  install_zoxide
  install_fortune
  install_ghostty

  if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
  fi

  print_success "All dependencies installed successfully!"
  print_message "Now you can run 'stow .' in your dotfiles directory."
  print_message "To apply the configuration, restart your terminal or run 'source ~/.zshrc'"
}

main

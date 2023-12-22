#!/bin/bash
# Mayanks setup script for setting up new dev laptop

# Variables
# List of Homebrew formulae to install (plugins and casks)
formulae=(
  "bat"
  "ripgrep"
  "fzf"
  "git"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "zsh-completions"
  "web-search"
  "cowsay"
  "fortune"
  "rtx"
  "lsd"
)
# Add more formulae as needed
# "go"
# "nvm"
# powerlevel10k
casks=(
  iterm2
  alt-tab
  rectangle
  appcleaner
)
# Add more casks as needed
# alfred
# stats

# # Manual Install just to have latest updates quicker
# logi-options-plus
# google-chrome
# visual-studio-code
# notion
# zoom
# etc

arch=$(uname -m)
curDir="$(dirname "$0")"

echo "Detected architecture: $arch"

# Check if the architecture is either x86_64 (Intel) or arm64 (Apple Silicon)
if [ "$arch" != "x86_64" ] && [ "$arch" != "arm64" ]; then
  # Unsupported architecture
  echo "Unsupported architecture: $arch. Cannot install Homebrew."
  exit 1
fi

echo "Starting machine setup..."

# Check if Xcode CLI Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode CLI Tools not found. Installing..."
  xcode-select --install

  # Wait for the installation to complete before continuing
  echo "Waiting for Xcode CLI Tools installation to finish..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done

  echo "Xcode CLI Tools installed successfully."
else
  echo "Xcode CLI Tools are already installed."
fi

if [ "$arch" == "x86_64" ]; then
  # Intel Mac
  echo "Detected Intel Mac. Installing Homebrew for Intel..."

  # Check if Homebrew is not installed
  if test ! "$(which brew)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
elif [ "$arch" == "arm64" ]; then
  # Apple Silicon Mac (M1)
  echo "Detected Apple Silicon Mac. Installing Homebrew for Apple Silicon..."

  # Check if Homebrew is not installed
  if test ! "$(which brew)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew is already installed."
  fi
fi

# Homebrew env setup on launch
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "Updating homebrew..."
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'
brew update
#brew update --force --quiet

promptUser() {
  while true; do
    read -r -p "$1 (y/n): " answer

    case "$answer" in
    [yY])
      return 0
      ;;
    [nN])
      echo "$2"
      if [ -n "$3" ]; then
        echo "Exiting the script!"
        exit 0
      fi
      return 2
      ;;
    *) ;;
    esac
  done
}

echoArrayElements() {
  local array=("$@")
  printf "\n"
  # Output array elements using a loop
  for element in "${array[@]}"; do
    echo "$element"
  done
  printf "\n"
}

# Function to install casks and formulae using brew
brewInstall() {
  # Check if Homebrew is installed
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    return 1
  fi

  local array=("$@")

  for package in "${array[@]}"; do
    if brew list "$package" &>/dev/null; then
      echo "$package is already installed. Skipping..."
    else
      if brew install "$package"; then
        echo "Successfully installed $package"
      else
        echo "Failed to install $package"
      fi
    fi
  done
}

promptUser "Do you want to continue and install Casks and Formulaes?" "Installed Brew and Xcode CLI." 1

printf "Starting install for Brew Casks and Formulaes...\n"

printf "\nFormulae:"
echoArrayElements "${formulae[@]}"
if promptUser "Are you okay with installing the above Formulaes?" "Skipped Formulae Install"; then
  # Install casks
  brewInstall "${formulae[@]}"
fi

printf "\nCasks:"
echoArrayElements "${casks[@]}"
if promptUser "Are you okay with installing the above Casks?" "Skipped Casks Install"; then
  # Install casks
  brewInstall "${casks[@]}"
fi

echo "Instillations Complete"

if promptUser "Do you want to hush login" "Will show continue to show login info in terminal on launch"; then
  # Adding this file to root will suppress login message in terminal
  touch ~/.hushlogin
fi

if promptUser "Do you want to install Nerd Fonts" "Please install font later as packages will require it"; then
  brew tap homebrew/cask-fonts
  brew install font-hack-nerd-font
fi

# Swapped with lsd
# if promptUser "Do you want to install colorls?" "Install this after if required"; then
#   # Check if Ruby and Gem are installed
#   if command -v ruby &> /dev/null && command -v gem &> /dev/null; then
#       # Check if the installation was successful
#       if gem install colorls; then
#           echo "colorls has been successfully installed."
#       else
#           echo "Installation failed. Please check your Ruby and Gem installation."
#       fi
#   else
#       echo "Ruby or Gem is not installed. Please install Ruby and try again."
#   fi
# fi

echo "Beginning symlink..."

echo "System Ready to use"

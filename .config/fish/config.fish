if status is-interactive
    # Commands to run in interactive sessions can go here
end

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function cd-pro
  cd ~/Documents/Professional
end

function cd-perso
  cd ~/Documents/Personal_Aymeric_Beudaert/
end

set -x PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
set -x PUPPETEER_EXECUTABLE_PATH (which chromium)
set -x ANDROID_SDK_ROOT /Users/aymeric/Library/Android/sdk
set PATH $PATH $ANDROID_SDK_ROOT/emulator
set PATH $PATH $ANDROID_SDK_ROOT/platform-tools

nvm use default


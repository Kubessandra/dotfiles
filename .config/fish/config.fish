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

function cd-tnv
  cd ~/Documents/Personal_Aymeric_Beudaert/TNV/tnv-v2/
end

set -x PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
set -x PUPPETEER_EXECUTABLE_PATH (which chromium)
set -x ANDROID_SDK_ROOT /Users/aymeric/Library/Android/sdk
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
set PATH $PATH $ANDROID_SDK_ROOT/emulator
set PATH $PATH $ANDROID_SDK_ROOT/platform-tools
set PATH $PATH /Users/aymeric/Library/Python/3.11/bin
set PATH $PATH ~/.bun/bin
set PATH $PATH $HOME/.maestro/bin

nvm use default


# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

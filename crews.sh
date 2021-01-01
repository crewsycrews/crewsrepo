#!/bin/sh

#run this as NOT-ROOT
LIST_OF_APPS="curl cargo cmake python php redis docker npm nodejs postgresql zsh"

apt update
sudo apt install -y $LIST_OF_APPS
sudo chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
wget -O ~/.zshrc https://github.com/crewsycrews/my-dotfiles-and-etc/raw/master/confs/.zshrc
cp -r confs/zsh-themes/ ~/.oh-my-zsh/custom/themes/ 
cargo install exa
wget https://github.com/be5invis/Iosevka/releases/download/v4.2.0/ttf-iosevka-4.2.0.zip
sudo unzip ttf-iosevka-4.2.0.zip -d /usr/share/fonts/iosevka
rm ttf-iosevka-4.2.0.zip

# start installing composer
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet --install-dir=/bin --filename=composer
RESULT=$?
exit $RESULT
# end installing composer
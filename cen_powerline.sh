
# install powerline:
sudo dnf install powerline powerline-fonts

# To make powerline active by default, place the code below at the end of your ~/.bashrc file (in useraccount and also in root!):
sudo echo "" >> ~/.bashrc
sudo echo "# Powerline" >> ~/.bashrc
sudo echo "" >> ~/.bashrc
sudo echo "if [ -f `which powerline-daemon` ]; then" >> ~/.bashrc
sudo echo "  powerline-daemon -q" >> ~/.bashrc
sudo echo "  POWERLINE_BASH_CONTINUATION=1" >> ~/.bashrc
sudo echo "  POWERLINE_BASH_SELECT=1" >> ~/.bashrc
sudo echo "  . /usr/share/powerline/bash/powerline.sh" >> ~/.bashrc
sudo echo "fi" >> ~/.bashrc

# Setting UID and GID for Docker container use
export UID=$(id -u)
export GID=$(id -g)

# Creating symlink to Xauthority file to pass it to Docker
ln -sf "$XAUTHORITY" ~/.Xauthority

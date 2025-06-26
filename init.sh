# ubuntu 24.04 on WSL

# update repositories and install weston
sudo apt update && sudo apt install weston xwayland

# create weston session systemd service
sudo bash -c "cat > /etc/systemd/user/weston-session.service" <<EOF
[Unit]
Description=Weston Session Service
After=network.target

[Service]
Type=simple
ExecStart=weston --backend=headless-backend.so
Restart=on-failure

[Install]
WantedBy=default.target
EOF

# enable and start weston systemd service
systemctl --user enable weston-session.service
systemctl --user start weston-session.service

# install waydroid installation dependencies
sudo apt install -y curl ca-certificates

# add waydroid official repository
curl -s https://repo.waydro.id | sudo bash

# install waydroid
sudo apt install -y waydroid

# clone anbox-modules from GitHub
git clone https://github.com/choff/anbox-modules

# copy anbox files
sudo cp anbox-modules/anbox.conf /etc/modules-load.d/
sudo cp anbox-modules/99-anbox.rules /lib/udev/rules.d/
sudo cp -rT anbox-modules/binder /usr/src/anbox-binder-1





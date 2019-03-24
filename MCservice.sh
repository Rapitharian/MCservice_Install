#!/bin/bash
# ./MCservice.sh 2>&1 | tee -a MCservice_Install.log
read -e -p "What user was used to install minecraft? [$USER]: " User1
User1=${USER1:-$USER}
# Install screen.
sudo yum -y install screen
# Create the minecraft service file.
/bin/cat <<EOM > $HOME/minecraft@.service
[Unit]
Description=Minecraft Server: %i
After=network.target

[Service]
WorkingDirectory=$HOME/%i
PrivateUsers=true # Users Database is not available for within the unit, only root and minecraft is available, everybody else is nobody
User=$User1
Group=$User1
ProtectSystem=full # Read only mapping of /usr /boot and /etc
#ProtectHome=true # /home, /root and /run/user seem to be empty from within the unit. It is recommended to enable this setting for all long-running services (in particular network-facing ones).
ProtectKernelTunables=true # /proc/sys, /sys, /proc/sysrq-trigger, /proc/latency_stats, /proc/acpi, /proc/timer_stats, /proc/fs and /proc/irq will be read-only within the unit. It is recommended to turn this on for most services.
# Implies MountFlags=slave
ProtectKernelModules=true # Block module system calls, also /usr/lib/modules. It is recommended to turn this on for most services that do not need special file systems or extra kernel modules to work
# Implies NoNewPrivileges=yes
ProtectControlGroups=true # It is hence recommended to turn this on for most services.
# Implies MountAPIVFS=yes
Restart=always
ExecStart=/usr/bin/screen -DmS mc-%i /usr/bin/java -Xmx2G -jar spigot.jar nogui
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "say SERVER SHUTTING DOWN IN 15 SECONDS..."\015'
ExecStop=/bin/sleep 5
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "say SERVER SHUTTING DOWN IN 10 SECONDS..."\015'
ExecStop=/bin/sleep 5
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "say SERVER SHUTTING DOWN IN 5 SECONDS..."\015'
ExecStop=/bin/sleep 5
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "save-all"\015'
ExecStop=/usr/bin/screen -p 0 -S mc-%i -X eval 'stuff "stop"\015'

[Install]
WantedBy=multi-user.target
EOM
# Add the executable permission to the minecraft@.service file.
chmod +x minecraft@.service
# Move the minecraft@.service file to /etc/systemd/system folder.
sudo mv $HOME/minecraft@.service /etc/systemd/system/minecraft@.service
# Change the ownership of the minecraft@.service file to root.
sudo chown root:root /etc/systemd/system/minecraft@.service
# Reload systemd units
sudo systemctl daemon-reload
# Remove the MCservice_Install directory.
sudo rm -rf $HOME/MCservice_Install
# Remove the old StartMC.sh script
rm StartMC.sh
# Start the server.
sudo systemctl start minecraft@spigotmc
# Enable (start after boot) the server.
sudo systemctl enable minecraft@spigotmc
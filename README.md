# MCservice_Install
Spigot minecraft server, servicize automation script

<b><u>Prerequistes:</u></b><br>
  Yu should already have installed Minecraft Spigot server using my install script.<br>
  You must be a sudo user, ie. in the sudoers group, or the root user to install run this script.<br>
  Running as root is NOT recommended!<br>

<b><u>Installation:</u></b><br>
  If your server system: Amazon Linux/CentOS/Fedora<br>
  Excecute the commands below from your servers console<br>
  Install git on the server if not alrady on the server.<br>
<pre>
sudo yum -y install git
</pre>
<br>

  Second clone this project and run the install script<br>
<pre>
git clone https://github.com/Rapitharian/MCservice_Install.git
mv $HOME/MCservice_Install/MCservice.sh $HOME
chmod +x MCservice.sh
./MCservice.sh 2>&1 | tee -a MCservice_Install.log
</pre>

<b><u>Test Installation:</u></b><br>
Check to ensure the service started.<br>
Assuming the service is active, connect to the active screen.<br>
<pre>
systemctl status minecraft@spigotmc 2>&1 | tee -a MCservice_Install.log
screen -r
</pre>
<b><u>Cleanup:</u></b><br>
Remove the installation script MCservice.sh<br>
If you don't need the installation log, remove that as well.<br>
<pre>
rm MCservice.sh
rm MCservice_Install.log
</pre>

<b><u>Screen usage:</u></b><br>
To connect to the screen from a terminal type "screen -r"<br>
To detach from a screen press "CTRL+A+D"<br>
To list the available screens type "screen -ls"<br>
To connect to a session type "screen -r NUMBERofTHEsession"<br>

Check Status of the minecraft server service: systemctl status minecraft@spigotmc<br>
Start the minecraft server service: systemctl start minecraft@spigotmc<br>
Stop the minecraft server service: systemctl stop minecraft@spigotmc<br>
Restart the minecraft server service: systemctl restart minecraft@spigotmc<br>

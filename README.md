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

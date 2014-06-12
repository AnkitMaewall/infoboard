# Readme

 Set up X.

	sudo pacman -S unclutter
	sudo pacman -S uzbl-browser
	sudo pacman -S make
	sudo pacman -S base-devel abs

	git clone ...
	cd ../dwm/
	make clean install

# Configured autologin
From the Arch-Wiki:
http://unix.stackexchange.com/questions/42359/how-can-i-autologin-to-desktop-with-systemd



    Create a new service file similar to getty@.service by copying it to /etc/systemd/system/

	    cp /usr/lib/systemd/system/getty@.service /etc/systemd/system/autologin@.service


ln -s /etc/systemd/system/autologin@.service /etc/systemd/system/getty.target.wants/getty@tty1.service`

ExecStart=-/sbin/agetty -a USERNAME %I 38400

systemctl daemon-reload
systemctl start getty@tty1.service

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx



Errors?
pacman -Syu
pacman -Syy

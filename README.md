# infoboard

**Project status: Heavy WIP. Just started.**

The goal of this project is to provide a simple infoboard.
The application does nothing else than to provide a simple way
of displaying an infoboard.

The data, which is displayed, comes from external scripts.  This is not part 
of this application, instead the configuration file provides the way of 
setting the data for the infoboard up. This is an example for a `config.js`.
	
	exports.config = {
		animated_transitions: false
		, screens: [
			{
				  cmd: "./screens/fortune.sh"
				, hold_for: 5000 //ms
			}
			, {
				  cmd: "./screens/clock.sh"
				, hold_for: 1000 
			}
		]
	};



## Installation

I use the Arch distribution for the RaspberryPi.
Set up X and install those packages:

	sudo pacman -S unclutter
	sudo pacman -S uzbl-browser
	sudo pacman -S make
	sudo pacman -S git
	sudo pacman -S nodejs
	sudo pacman -S base-devel abs

	git clone ...
	cd ./dwm/
	make clean install

	cd ./infoboard/
	npm install

Encountering errors?

	pacman -Syy # try to update the mirrorlist first
	pacman -Syu # you may try to upgrade everything, if that doesn't work out


## Autologin

In order for the infoboard to boot up without blocking you should configure
autlogin. I followed [these](http://unix.stackexchange.com/questions/42359/how-can-i-autologin-to-desktop-with-systemd)
instructions, which summarized are:

	Create a new service file similar to getty@.service by copying it to /etc/systemd/system/
	cp /usr/lib/systemd/system/getty@.service /etc/systemd/system/autologin@.service

	# Content:
	ExecStart=-/sbin/agetty -a USERNAME %I 38400

	ln -s /etc/systemd/system/autologin@.service /etc/systemd/system/getty.target.wants/getty@tty1.service`

	systemctl daemon-reload
	systemctl start getty@tty1.service


# License

The code is licensed under the MIT license:

	Copyright (c) 2014

		Michael Mueller <http://micha.elmueller.net/>

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

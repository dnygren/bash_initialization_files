# Used with the Zedboard attached via USB to the laptop
alias mc='echo Make sure board attached to serial port is on.;
echo Make sure only one minicom application running on this port;
sudo minicom -D /dev/ttyACM0 -b 115200 -8 -w'
alias petalinux-source='source /opt/pkg/petalinux/settings.sh ; echo PETALINUX = $PETALINUX'

# Often (but not always) helps resolve KDE Plasma Desktop lockup issues
alias restart-plasma='killall plasmashell ;sleep 5 ;kstart plamsashell'

# VNC
alias vncdell='/usr/bin/vncserver -geometry 2560x1440'
alias vncpanasonic='/usr/bin/vncserver -geometry 1920x1080'
#alias vncpasswd='/usr/bin/vncpasswd'
# Run vncserver with a standard resolution
# For Ultra 5 & 19" Monitor
#alias vncbig='/usr/bin/vncserver -depth 32 -geometry 1024x768 -alwaysshared -fp tcp/localhost:7100'
# For a lot of clients using Ultra 5 & 19" Monitors
#alias vncbigcrowd='/usr/bin/vncserver -depth 32 -geometry 1024x768 -deferupdate 1000 -alwaysshared -fp tcp/localhost:7100'
# For a Wide Screen Monitor
#alias vnchuge='/pkg/local/bin/vncserver -depth 32 -geometry 1680x1024 -alwaysshared'
#alias vnchuge='/usr/bin/vncserver -depth 32 -geometry 1680x1024 -alwaysshared -fp tcp/localhost:7100'
# For a Sun 24.1" Wide Screen Monitor
#alias vncmassive='/usr/bin/vncserver -depth 32 -geometry 1892x1154 -alwaysshared -fp tcp/localhost:7100'
#alias vncsun='/usr/bin/vncserver -depth 32 -geometry 1912x1172 -alwaysshared -fp tcp/localhost:7100'
#alias vncsun='/usr/bin/vncserver -depth 32 -geometry 1910x1168 -alwaysshared -fp tcp/localhost:7100'
# For HP Laptop
#alias vncsmall='/usr/bin/vncserver -depth 32 -geometry 1248x560 -alwaysshared -fp tcp/localhost:7100'
# For Toshiba Laptop
#alias vnctoshiba='/usr/bin/vncserver -depth 32 -geometry 1540x768 -alwaysshared -fp tcp/localhost:7100'
# For View Sonic Monitor
#alias vncviewsonic='/usr/bin/vncserver -depth 32 -geometry 1680x976 -alwaysshared -fp tcp/localhost:7100'

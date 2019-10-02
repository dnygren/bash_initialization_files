################################################################################
# Find a file in a file tree
# (Excludes the NetApp .snapshot hidden backup directories.)
# Usage: findfile file_name
#
# Note wildcards must be enclosed with single quotes on the command line or
# they will be passed to this function already expanded which is likely not
# what the user intended. 
#
# Example findfile '*.xls'
################################################################################
function findfile
{
	echo "Not searching hidden .snapshot NetApp directories"
        #find . -name "$1" -print
	find . -path ./.snapshot -prune -o -name "$1" -print
}

# Same as above but directs stderr to /dev/null.
# Handy when lots of files and directories in tree have permission issues.
function findfilequiet
{
	find . -name "$1" -print 2>/dev/null
}

################################################################################
# Find a string in any file in a file tree, 
# ignoring case, print only one line, 
# no matter how many instances found in a file 
################################################################################
function findstring 
{ 
	echo "Ignoring case"
# find . -type f -exec grep -li "$*" {} \; #Usage: findstring string
# pass at least 2 filenames to grep so grep will always print the filenames
    find . -type f -exec grep -li "$*" /dev/null {} +
}

# Same as above but directs stderr to /dev/null.
# Handy when lots of files and directories in tree have permission issues.
function findstringquiet 
{ 
	echo "Ignoring case"
    find . -type f -exec grep -li "$*" /dev/null {} + 2>/dev/null
}


################################################################################
# Find all the files below the current # directory greater than $1 bytes in size
# sort by human readable file size criteria, excluding the NetApp .snapshot
# hidden backup directories.
################################################################################
function findbig
{
	/usr/bin/find . -path ./.snapshot -prune -o -size +$1c -print0 | \
            /usr/bin/xargs -0 --no-run-if-empty ls -lh | sort -h -r -k 5
}


################################################################################
# Bookmark directories (From June 2001 SW Expert "Work" column)
# $ mark foo $ go foo
################################################################################
function mark
{
	eval d_$1=$PWD
}
function go
{
	eval cd \$d_$1
}
################################################################################
# Take a snapshot of an X-window and covert it to a PNG
################################################################################
function snapshot
{
	YEARDAY=$(/usr/xpg4/bin/date '+%C%y-%m-%dT%H%M%S')
	/usr/bin/xwd | /usr/bin/convert - snapshot.$YEARDAY.png
	# Commented out as "display" doesn't work on Sunray, so use gimp
	/usr/bin/display snapshot.$YEARDAY.png
    # Commented out GIMP when they fixed Imagemagick "display"
	#/usr/sfw/bin/gimp snapshot.$YEARDAY.png
}

################################################################################
# Covert file.pdf to a 2up PostScript document file2_d.ps
# Usage: twopostscript file.pdf
################################################################################
function twopostscript
{
	/usr/dist/share/acroread,v5.08/bin/acroread -toPostScript $1
	/pkg/local/bin/mpage -2 ${1%.pdf}.ps | /pkg/local/bin/psset -d > ${1%.pdf}_2d.ps
	ls -la ${1%.pdf}_2d.ps
}

################################################################################
# Make exporting the DISPLAY less annoying
# Usage: e IP.AD.DR.ES 
################################################################################
function e
{
	export DISPLAY="$1":0.0
}
################################################################################
# Sort directories by size of contents
################################################################################
function findbigdir
{
	/usr/bin/find . -type d -print0 | /usr/bin/xargs -0 -n1 du -sk | sort -n
}

################################################################################
# Shrink JPEG photos down to smallest viewable size
################################################################################
function shrinkjpg
{
	/usr/bin/convert -quality 15 $1 ${1%.jpg}_q15.jpg
}

################################################################################
# Configuring ssh-agent
################################################################################
function sa
{
exec /usr/bin/ssh-agent $SHELL
ssh-add
}
################################################################################
# ssh to a certain build server
################################################################################
function build
{
	~/bin/ssx scapen-cs11u3-0
}
function build2
{
	~/bin/ssx scapen-cs11u3-2
}
function build4
{
	~/bin/ssx scapen-cs11u2-0
}
################################################################################
# ssh to a certain simulation server
################################################################################
function sim
{
	~/bin/ssx dt240-161
}

################################################################################
# Find a string in any file in a file tree, 
# ignoring case, print only one line, 
# no matter how many instances found in a file 
# Example: find . -name "errno.h" -exec grep -li "EINVAL" /dev/null {} +
# Example: findstringinfile EINVAL errno.h
################################################################################
function findstringinfile 
{
	find . -name "$2" -exec grep -li "$1" /dev/null {} +
}

################################################################################
# Functions that allow me to "alias" the make I want to use
# so I can call them from another script like "et"
################################################################################
function dmake
{
	# $@ used to accept "dmake lint" "dmake clean" etc.
	/ws/onnv-tools/SUNWspro/SS12/bin/dmake $@
}
function dmakeg
{
	/ws/onnv-tools/SUNWspro/SS12/bin/dmake -e COMPILER=GNU $@
}
################################################################################
# spell $Revision$ :  A non-interactive quick and dirty spell check
#
# by Dan Nygren $Date$
# E-mail: dan.nygren@gmail.com 
#
# 	spell is a non-interactive spell check similar to the original Unix
# spell command. Add this to your ~/.bash_functions and invoke as "spell
# source_code.c" etc.  Page through the output using the spacebar and observe
# any spelling errors while ignoring obvious software constructs. Then go back
# to your source code and fix the typos and run this spell check again.
#
#
# CALLING SEQUENCE      spell filename
#
# EXAMPLES              spell source_code.c
#
# TARGET SYSTEM         Linux
#
# DEVELOPMENT SYSTEM    Debian 9 Linux  
#
# CALLS                 hunspell, sort, uniq, less
#
# CALLED BY             N/A
#
# INPUTS                source code file
#
# OUTPUTS               stdout paged by less
#
# RETURNS               N/A
#
# ERROR HANDLING        N/A
#
# WARNINGS              
#			Note you can install hunspell and the US English
#			dictionary on Debian Linux with the following
#			commands (assumes you have sudo access):
#			$ sudo apt install hunspell
#			$ sudo apt install hunspell-en-us
#
###########################################################################
function spell
{
    hunspell -l $* | sort | uniq | less
}

################################################################################
# Tells "How Many?" users are logged in
################################################################################
function howmany
{
	who | sort | cut -d' ' -f1 | uniq | wc -l
}
################################################################################
# Enscript printing
################################################################################
function 1up
{
	/usr/bin/enscript -G --pretty-print --font=Courier11 "$1"
}
function 2up
{
	/usr/bin/enscript -2rlG --pretty-print "$1"
}
function landscape
{
	/usr/bin/enscript -G --pretty-print --font=Courier7 --landscape "$1"        
}
function gutenberg
{
	/usr/bin/enscript -2 --landscape --borders --header='$n Page $% of $=' --filter="fmt -w 80 %s" --font=NewCenturySchlbk-Roman9 "$1" --output  "$1".ps
# --encoding=dos --page-label-format=short  --filter="dos2unix -ascii < %s | fmt -w 72" --font=Times-Roman12
}

################################################################################
# kill a numbered vnc session
# Usage:    vnckill num
# Example:  vnckill 1
################################################################################
function vnckill
{
	/usr/bin/vncserver -kill :$1
}
################################################################################
# Tells which ssh sessions are mine
################################################################################
function sshwhich
{
	 ps -ef | grep 'nygren' | grep 'ssh'
}
################################################################################
# Tells which vnc sessions are mine
################################################################################
function vncwhich
{
	 ps -ef | grep 'nygren' | grep 'vnc'
}
################################################################################
# Set up ssh tunnel to VNC server using an IP address
# Usage:    vnciptunnel num
# Example:  client$ vnciptunnel 1
#           server$ vncserver
#           client$ nohup vncviewer :1 &
#           (Do whatever on VNC)
#           (Cleanup)
#           server$ vncserver -kill :1
#           client$ ps -ef | grep vncviewer
#           client$ kill 123456
#
# Set up ssh tunnel to ssh server then a tunnel from ssh server to VNC server
# Public IP for server and revres:
# tenhut.example.com  203.0.113.23
# hutten.example.com  203.0.113.22
# Example:  home $ ssh -L 5901:localhost:5901 -N -f -l nygren <IP of ssh server>
#           home  $ ssh -l nygren tenhut.example.com
#           tenhut$ vnciptunnel 1
#           server$ vncserver
#           home  $ nohup vncviewer :1 &
#           (Do whatever on VNC)
#           (Cleanup)
#           server$ vncserver -kill :1
#           client$ ps -ef | grep vncviewer
#           client$ kill 123456
################################################################################
function vnciptunnel
{
    if [[ $# -ne 1 ]]
    then
        echo "Number of parameters = $# ."
        echo "One and only one parameter required for tunnel."
        echo "This parameter is added to 5900 to create ssh tunnel port number."
        return 1 # return false
    fi

    BASE_PORT=5900
    USER_NAME=nygren
    VNC_SERVER=mmo-proc.example.com

# ssh flag meanings
# -L localport:host:hostport
# -N Just port forward
# -f ssh to background
# -l user login on remote host

    IP_ADDRESS=$(/usr/bin/nslookup $VNC_SERVER | /bin/grep "Address: " | /usr/bin/cut -d' ' -f2)

    echo $IP_ADDRESS
    echo $USER_NAME
    /usr/bin/ssh -L $(($BASE_PORT + $1)):localhost:$(($BASE_PORT + $1)) -N -f -l $USER_NAME $IP_ADDRESS
}
################################################################################
# Set up an ssh tunnel to the VNC server.
# Usage:    vnctunnel num
# Example:  client$ vnctunnel 1
#           server$ vncserver
#           client$ nohup vncviewer :1 &
#           (Do whatever on VNC)
#           (Cleanup)
#           server$ vncserver -kill :1
#           client$ ps -ef | grep vncviewer
#           client$ kill 123456
#
# Set up an ssh tunnel to an ssh server,
# then tunnel as above from ssh server to VNC server.
# Example:  home  $ remotevnctunnel 1
#           home  $ ssh -l nygren tenhut.example.com
#           tenhut$ vnctunnel 1
#           tenhut$ ssh -l nygren <server like mmo-proc>
#           server$ vncserver
#           home  $ nohup vncviewer :1 & <OR> Windows tightvnc localhost:1
#           (Do whatever on VNC)
#           (Cleanup)
#           server$ vncserver -kill :1
#           client$ ps -ef | grep vncviewer
#           client$ kill 123456
################################################################################
function vnctunnel
{
    if [[ $# -ne 1 ]]
    then
        echo "Number of parameters = $# ."
        echo "One and only one parameter required for tunnel."
        echo "This parameter is added to 5900 to create ssh tunnel port number."
        return 1 # return false
    fi

    BASE_PORT=5900
    USER_NAME=nygren
    VNC_SERVER=mmo-proc.example.com

# ssh flag meanings
# -L localport:host:hostport
# -N Just port forward
# -f ssh to background
# -l user login on remote host

    echo $VNC_SERVER
    echo $USER_NAME
    /usr/bin/ssh -L $(($BASE_PORT + $1)):localhost:$(($BASE_PORT + $1)) -N -f $USER_NAME@$VNC_SERVER
}
function remotevnctunnel
{
    if [[ $# -ne 1 ]]
    then
        echo "Number of parameters = $# ."
        echo "One and only one parameter required for tunnel."
        echo "This parameter is added to 5900 to create ssh tunnel port number."
        return 1 # return false
    fi

    BASE_PORT=5900
    USER_NAME=nygren
    SSH_SERVER=tenhut.example.com
    # SSH_SERVER=tarkas.example.com

# ssh flag meanings
# -L localport:host:hostport
# -N Just port forward
# -f ssh to background
# -l user login on remote host

    echo $SSH_SERVER
    echo $USER_NAME
    /usr/bin/ssh -L $(($BASE_PORT + $1)):localhost:$(($BASE_PORT + $1)) -N -f $USER_NAME@$SSH_SERVER
}
################################################################################
# View a numbered vnc session without having to keep a terminal open
# Usage:    vncv num
# Example:  vncv 1
################################################################################
function vncv
{
    if [[ $# -ne 1 ]]
    then
        echo "Number of parameters = $# ."
        echo "One and only one parameter required for vncviewer."
        return 1 # return false
    fi

	nohup /usr/bin/vncviewer :$1 &
}

# One line calculator (e.g. $calc 1 + 1)
function calc
{
    #/usr/bin/gawk "BEGIN { print $* ; }"
    /usr/bin/bc -l <<< "$@"
}

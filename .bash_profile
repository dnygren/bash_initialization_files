# ~/.bash_profile: executed by bash(1) for login shells.
# Sources ~/.bashrc when complete.

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH="${HOME}/bin:${PATH}"
# fi

#### Linux uses /etc/man.config unless overridden by MANPATH.  ####
# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi

#### Dan Nygren's Additions ####

# Don't allow group or others default file read, write, or directory access
# permissions
umask 077

#### Various utilities want a default editor defined
export EDITOR="/usr/bin/vim"

#### For enscript
export NAME="Dan Nygren"

#### Look in /usr/local/bin first for locally compiled executables ####
export PATH=/usr/local/bin

#### To put my own bin and scripts directories in front of the usual places ####
export PATH=$PATH:$HOME/bin:$HOME/public_html/scripts:/bin:/usr/bin

#### /usr/sbin contains system tools,
#### and /sbin contains system tools need if /usr isn't mounted ####
export PATH=$PATH:/usr/sbin:/sbin

#### For arc / php (Phabricator)  ####
#export PATH=$PATH:/usr/php/bin

#### For ASI's devtool  ####
export PATH=$PATH:~/.asi

#### For Python files installed with --user ####
export PATH=$PATH:~/.local/bin

#### Current working directory is last in PATH
export PATH=$PATH:.

### For dmake parallel make ###
# ("dmake -j <# of jobs>", or set the DMAKE_MAX_JOBS environment variable).
# export DMAKE_MAX_JOBS=999

# Source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin/:$PATH
export MANPATH=/opt/local/man/:$MANPATH
export DISPLAY=:0.0

# allow color with standard macosx tools
export CLICOLOR=1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"  
fi

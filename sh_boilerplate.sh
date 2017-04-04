#!/bin/bash
# sh_boilerplate: sample shell script to accept command line arguments, detect OS and interact with user 

# OS
OS=$( uname -s )
# script information
PROGNAME=$( basename $0 )
TITLE="open website in all browsers"
CURRENT_TIME=$( date +"%x %r %Z"  )
TIMESTAMP="Generated $CURRENT_TIME, by $USER"

# routines
usage () {
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
	return
}

# detect OS
if [ "${OS}" == "Darwin" ]; then
	# detect Mac OS version
	MACOS_NAME=`sw_vers -productName`
	MACOS_VER=$(sw_vers -poductVersion | awk -F '.' '{print $1 "." $2}')

	if [[ "${MACOS_NAME}" == "Mac OS X" ]]; then
		# do something
		echo "This is a mac"
	else
		echo "Unsupported MAC OS X version (${MACOS_NAME} ${MA})"
		exit 1
	fi
elif [ "${OS}" == "Linux" ]; then
	# detect Linux version
    KERNEL=`uname -r`
    if [ -f /etc/redhat-release ]; then
        DIST='RedHat'
        PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
        REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/SuSE-release ]; then
        DIST=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
        REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
    elif [ -f /etc/mandrake-release ]; then
        DIST='Mandrake'
        PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
        REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/debian_version ]; then
        DIST="Debian `cat /etc/debian_version`"
        REV=""
    fi

    if [ -f /etc/UnitedLinux-release ]; then
        DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
    fi

    if command_exists apt-get; then
        if ! command_exists git; then
            sudo apt-get install git
        fi
    elif command_exists yum; then
        # This may install an ancient version of Node - no guarantees :/
        # Try: https://github.com/nodesource/distributions
        if ! command_exists git; then
            sudo yum install -y git
        fi
	else
        echo "This linux dist (${DIST}) doesn't support apt-get or yum. Exiting."
        exit 1
    fi
else
    echo "Unsupported OS for installation scripts - ${OS}"
	exit 1
fi

# process command line options
interactive=
filename=
while [[ -n $1 ]]; do
	case $1 in
		-f | --file)		shift
							filename=$1
							;;
		-i | --interactive)	interactive=1
							;;
		-h | --help)		usage
							exit
							;;
		*)					usage >&2
							exit 1
							;;
	esac
	shift
done

# interactive mode
if [[ -n $interactive ]]; th
	while true; do
		read -p "Enter name of output file: " filename
		if [[ -e $filename ]]; th
			read -p "'$filename' exists. Overrite? [y/n/q] > "
			case $REPLY in
				Y|y)	break
						;;
				Q|q)	echo "Program Terminated."
						exit
						;;
				N|n)	continue
						;;
				*)		continue
						;;
			esac
		fi
	done
fi

# furthur process


#!/bin/ksh
# REVISION MEMORIA AIX
#

help_usage() {
    echo "Usage:"
        echo " $0 -c (critical) -w (warning)"
        echo " $0 (-v | --version)"
        echo " $0 (-h | --help)"
}

help_version() {
    echo "check_AIX_memory (nagios-plugins) 1.0"
    echo "The nagios plugins comes with ABSOLUTELY NO WARRANTY. You may redistribute"
    echo "copies of the plugins under the terms of the GNU General Public License."
    echo "2015 Todd Litteken <cl@xganon.com>"
}

myself=$0

if [ "$1" = "-h" -o "$1" = "--help" ]; then
        help_version
        echo ""
        echo "This plugin will check if memory is ok."
        echo ""
        help_usage
        echo ""
        echo "Required Arguments:"
        echo " -c ## -w ##"
        echo ""
        exit 3
fi

if [ "$1" = "-v" -o "$1" = "--version" ]; then
        help_version
        exit 3
fi

if [ `echo $@|tr "=" " "|wc -w` -lt 4 ]; then
        echo "Bad arguments number (need four)!"
        help_usage
        exit 3
fi

stream=""
wt=""
ct=""
crit=""

# Test of the command lines arguments
while test $# -gt 0
do
    case "$1" in
            -c)
                shift
                CRITICAL="`echo $1`"
                ;;
            -w)
                shift
                WARNING="`echo $1`"
                ;;
            *)
                echo "Unknown argument $1"
                help_usage
                exit 3
                ;;
    esac
    shift
done

total=$(svmon -G -O unit=MB |grep memory |awk '{print $2}')
PERCENTUSED=$(svmon -G -O unit=MB |grep "in use" |awk '{printf "%2.0f\n",$3*100/('$total')}')

if [ "$PERCENTUSED" -gt "$WARNING" ] && [ "$PERCENTUSED" -lt "$CRITICAL" ]; then
    crit=1
elif [ "$PERCENTUSED" -ge "$CRITICAL" ]; then
    crit=2
else
    crit=0
fi

# Finally Inform Nagios of what we found...
if [ $crit -eq 1 ]; then
    echo "WARNING -  Memoria Utilizada $PERCENTUSED%"
    exit 1
elif [ $crit -eq 2 ]; then
    echo "CRITICAL -  Memoria Utilizada $PERCENTUSED%"
    exit 2
else
    echo "OK -  Memoria Utilizada $PERCENTUSED%"
    exit 0
fi
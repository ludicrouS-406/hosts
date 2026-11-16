echo "starting ip checking"
echo "izzy forked this repo"
flag=0
while read p; do
	if [[ "$flag" == 1 ]]; then
		a=( $p )
		ip=${a[0]}
		nm=${a[1]}
		rip=$(nslookup $nm 8.8.8.8 | awk '/^Address: / { print $2 }')
		lrip=( $rip )
		if [[ $ip != ${lrip[0]} ]]; then
			echo "Bogus IP for ${nm} in /etc/hosts!"
		fi
	fi
	if [[ "$p" == "# addresses I added" ]]; then
		flag=1
	fi
done </etc/hosts

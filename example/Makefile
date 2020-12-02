ALL: compile

compile:
	git pull
	cd /opt/fw-lua;git pull;make

apply:
	cd /opt/fw-lua;git pull;make apply

sync-fw1:
	-git commit -a
	git push
	ssh fw2 "cd /etc/fw;git pull;make;make apply"

sync-fw2:
	-git commit -a
	git push
	ssh fw1 "cd /etc/fw;git pull;make;make apply"

sync: sync-$(shell uname -n)

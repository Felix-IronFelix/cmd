#! /bin/bash

# Часы с кукушкой на каждый час рабочего времени

# Выдвинули лоток CD-ROM
eject /dev/cdrom
KUKU=$(date +%I)


case $KUKU in

	08)
		KUKU=8
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	09)
		KUKU=9
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	10)
		KUKU=10
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	11)
		KUKU=11
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	12)
		KUKU=12
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	01)
		KUKU=1
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	02)
		KUKU=2
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	03)
		KUKU=3
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	04)
		KUKU=4
		while [ $KUKU -gt 0 ]; do
			env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/kuku1.wav
			KUKU=$((KUKU-1))
		done
		;;
	05)
		env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/gromkiy-krik-vzroslogo-petuha.wav
		env XDG_RUNTIME_DIR=/run/user/1000 env XAUTHORITY=/home/user/.Xauthority /usr/bin/mplayer /home/user/music/derevnja-durakov-soundtrack-kalambur.mp3
		;;
esac

# Задвинули лоток CD-ROM
eject -t /dev/cdrom

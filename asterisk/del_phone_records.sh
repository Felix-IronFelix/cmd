#!/bin/bash

# Этот скрипт нужен для очистки каталогов с записями телефонных разговоров
# которые Asterisk зачем-то пишет автоматически.
# Структура каталогов там такая:
# /var/spool/asterisk/monitor/год/месяц
# И надо бы 1 числа каждого месяца удалять каталог предыдущего месяца,
# т.к. эти записи никому нафиг не нужны, а место на диске занимают.

# date +%C покажет первые две цифры текущего года
# date +%g покажет последние две цифры текущего года
# то есть date +%C%g покажет все четыре цифры года!

curyear=$(date +%C%g)

# date +%b покажет месяц первыми тремя буквами, т.е. янв, фев и так далее
curmonth=$(date +%b)
# echo $curmonth

case $curmonth in

	янв)
		# echo "Сейчас январь"
		# declare -i объявляет переменные числами, чтобы с ними можно было
		# производить арифметические действия
		declare -i curyear prevyear
		prevyear=$curyear-1
		# echo $prevyear
		/bin/rm -r /var/spool/asterisk/monitor/$prevyear/
		;;
	фев)
		# echo "Сейчас февраль"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/01/
		;;
	мар)
		# echo "Сейчас март"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/02/
		;;
	апр)
		# echo "Сейчас апрель"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/03/
		;;
	мая)
		# echo "Сейчас май"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/04/
		;;
	июн)
		# echo "Сейчас июнь"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/05/
		;;
	июл)
		# echo "Сейчас июль"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/06/
		;;
	авг)
		# echo "Сейчас август"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/07/
		;;
	сен)
		# echo "Сейчас сентябрь"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/08/
		;;
	окт)
		# echo "Сейчас октябрь"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/09/
		;;
	ноя)
		# echo "Сейчас ноябрь"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/10/
		;;
	дек)
		# echo "Сейчас декабрь"
		/bin/rm -r /var/spool/asterisk/monitor/$curyear/11/
		;;
esac

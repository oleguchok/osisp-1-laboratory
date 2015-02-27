#7. Написать скрипт подсчитывающий суммарный размер файлов в заданном каталоге
#и всех его подкаталогах (имя каталога задаётся пользователем в качестве
#аргумента командной строки). Скрипт выводит результаты подсчёта в файл (второй
#аргумент командной строки) в виде каталог (полный путь), суммарный размер
#файлов число просмотренных файлов.

#!/bin/bash
>$2
IFS=$'\n'
path=$( readlink -f $1  2>/tmp/errors.err )
for i in $((find $path -type d) 2>>/tmp/errors.err); do
	count=0
	size=0
	for  j in $((find $i -maxdepth 1 -type f)2>>/tmp/errors.err); do
		let count=count+1
		let size=$(( stat -c %s $j)2>>/tmp/errors.err)+size
	done
	echo "$i $size $count">>$2
done

while read line; do
	echo "${0##*/}: $line"
done <  /tmp/errors.err
rm /tmp/errors.err

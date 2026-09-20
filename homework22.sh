#!/bin/bash
//1
read -p "Մուտքագրեք ֆայլի անունը: " file
if [[ -f "$file" ]]
then
    read -p "Ինչ բառ փնտրել: " word

    until grep -q "$word" "$file"
    do
        echo "Բառը չի գտնվել։"
        read -p "Մուտքագրեք մեկ այլ բառ: " word
    done

    echo "Բառը գտնվեց հետևյալ տողում՝"
    grep -n "$word" "$file"
else
    echo "Ֆայլը չի գտնվել։"
fi
//2
factorial() {
    n=$1

    if [ $n -le 1 ]; then
        echo 1
    else
        result=$(factorial $((n - 1)))
        echo $((n * result))
    fi
}

factorial $1
//3


lines=0
words=0
chars=0

while read line
do
    lines=$((lines + 1))

    read -ra arr <<< "$line"
    words=$((words + ${#arr[@]}))

    chars=$((chars + ${#line}))
done < data.txt

echo "Lines: $lines"
echo "Words: $words"
echo "Characters: $chars"
//4 
#!/bin/bash

host="127.0.0.1"

ports=(22 80 443)

for port in "${ports[@]}"
do
    if (echo > /dev/tcp/"$host"/"$port") 2>/dev/null
    then
        echo "Port $port is OPEN"
    else
        echo "Port $port is CLOSED"
    fi
done
//5
#!/bin/bash

urls=(
    "https://google.com"
    "https://github.com"
    "https://example.com"
)

for url in "${urls[@]}"
do
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    echo "$url -> HTTP $status"

    if [ "$status" -eq 200 ]; then
        echo "Status: OK"
    elif [ "$status" -eq 301 ] || [ "$status" -eq 302 ]; then
        echo "Status: Redirect"
    elif [ "$status" -eq 403 ]; then
        echo "Status: Forbidden"
    elif [ "$status" -eq 404 ]; then
        echo "Status: Not Found"
    elif [ "$status" -eq 000 ]; then
        echo "Status: Connection refused / unavailable"
    else
        echo "Status: Other"
    fi

    echo
done
//6
#!/bin/bash

declare -A hits

while read ip
do
    hits[$ip]=$((hits[$ip] + 1))
done < access.log

for ip in "${!hits[@]}"
do
    echo "$ip -> ${hits[$ip]}"
    if [ "${hits[$ip]}" -gt 3 ]; then
        echo "  ⚠ Duplicate: more than 3"
    fi
done
//7
#!/bin/bash

read -p "File/dir: " path

if [ -e "$path" ]; then
    read -p "Վստա՞հ ես (yes/no): " answer

    if [ "$answer" = "yes" ]; then
        rm -rf "$path"
        echo "Deleted"
    else
        echo "Cancelled"
    fi
else
    echo "Not found"
fi


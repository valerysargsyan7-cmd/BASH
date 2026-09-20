#!/bin/bash
//1 
while read -r line
do
    if [[ "$line" == *"ERROR"* || "$line" == *"CRITICAL"* ]]
    then
        echo "$line" >> issues.txt
    fi
done < system.log
//2
files=("/etc/passwd" "/etc/hosts" "/etc/resolv.conf")

for file in "${files[@]}"
do
    if [ ! -e "$file" ] || [ ! -r "$file" ]
    then
        echo "ALERT: $file-ը բացակայում է կամ ընթեռնելի չէ"
    else
        echo "OK: $file-ը գոյություն ունի և ընթեռնելի է"
    fi
done
//3
while true
do
    echo "1. Ստուգել ցանցը"
    echo "2. Տեսնել պրոցեսները"
    echo "3. Դուրս գալ"

    read -p "Ընտրեք թիվը:" choice

    case $choice in
        1)
            echo "Ցանցը ակտիվ է"
            ;;
        2)
            echo "Պրոցեսները նորմալ են"
            ;;
        3)
            break
            ;;
        *)
            echo "Սխալ մուտքագրում"
            ;;
    esac
done
//4 
ips=("1.1.1.1" "8.8.8.8" "1.1.1.1" "10.0.0.1")

declare -A counts

for ip in "${ips[@]}"
do
    ((counts[$ip]++))
done

for ip in "${!counts[@]}"
do
    echo "$ip: ${counts[$ip]}"
done
//5


while true
do
    read -p "Մուտքագրեք էլ. հասցեն: " email

    if [[ "$email" =~ ^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$ ]]
    then
        echo "Էլ. հասցեն ճիշտ է։"
        break
    else
        echo "Սխալ էլ. հասցե։ Փորձեք կրկին։"
    fi
done
//6


stop_process() {
    pid=$(pgrep "$1")

    if [[ -n "$pid" ]]
    then
        echo "Կանգնեցվում է պրոցեսը՝ $pid"
    else
        echo "Պրոցեսը չի գտնվել"
    fi
}

stop_process "nginx"
//7
encoded="THiS_iS_A_TExT"
text=${encoded//_/ }
text=${text,,}

echo "$text"
//8


for file in *.bak
do
   
    [ -e "$file" ] || continue

    newname="${file%.bak}.old"

    mv "$file" "$newname"

    echo "$file -> $newname"
done



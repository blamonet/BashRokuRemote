#! /bin/bash
#export ROKU_IP="10.0.1.9"

function find_roku {
  echo "Finding Roku..."
  for i in $(arp -a | awk '{print $2}' | sed "s/[(|)]//g"); do 
    ct=`curl --max-time 1 -s $i:8060 | grep -i roku | wc -l`
    if [[ $ct -gt 1 ]]; then 
      export ROKU_IP=$i
      echo "Roku IP is $i"
    fi
  done
}

function roku {
  echo "Welcome to the Roku Bash Remote!"

  if [[ ! $ROKU_IP ]]; then 
    find_roku; 
  fi;  

  if [[ ! $ROKU_IP ]]; then 
    echo "Player not found"
    return 1
  fi;  

  echo
  echo "Your player is at $ROKU_IP"
  echo

  while [ TRUE ]; do
    echo
    echo "------------"
    echo "w) Up"
    echo "a) Left"
    echo "d) Right"
    echo "s) Down"
    echo "v) Select"
    echo "x) Play"
    echo "b) Back"
    echo "h) Home"
    echo "q) Quit"

    read -n 1 key
    echo "------------"
    echo

    if [[ $key == w ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Up
    elif [[ $key == s ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Down
    elif [[ $key == a ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Left
    elif [[ $key == d ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Right
    elif [[ $key == v ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Select
    elif [[ $key == x ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Play
    elif [[ $key == b ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Back
    elif [[ $key == h ]]; then
      curl -d "" http://$ROKU_IP:8060/keypress/Home
    elif [[ $key == q ]]; then
      return 0
    fi

  done
}
roku

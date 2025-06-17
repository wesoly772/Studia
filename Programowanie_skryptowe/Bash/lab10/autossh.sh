#!/bin/bash

SERVER="192.168.158.129"
USERNAME="kali"

payload="pwd; ls; ps aux"
ssh -l  $USERNAME $SERVER $payload > output.txt

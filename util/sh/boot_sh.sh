#!/bin/bash

ip=$(ip route get 8.8.8.8 | awk '{print $7; exit}')
echo "$ip"

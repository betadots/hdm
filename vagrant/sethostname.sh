#!/bin/bash
hostn=$1
echo "### Setting hostname ${hostn}"
hostnamectl set-hostname --static $hostn

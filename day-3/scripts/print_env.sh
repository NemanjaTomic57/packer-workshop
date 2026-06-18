#!/bin/sh -eux

env
whoami

env > "$HOME"/environment.txt

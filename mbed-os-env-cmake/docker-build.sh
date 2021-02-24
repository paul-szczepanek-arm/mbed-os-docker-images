#!/bin/bash
set -e

docker build "$@" -t mbed/mbed-os-env-cmake .
#!/bin/bash

iruby notebook --ip=`hostname -i` --allow-root --no-browser "$@" 
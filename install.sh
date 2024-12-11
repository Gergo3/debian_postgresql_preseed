#!/bin/sh

set +x

echo 1 > /target/base-prs-scr

echo 'Running final installer scripts'

for f in /cdrom/preseed/install.d/*.sh; do
    echo "Running $f ..."

    /bin/sh "$f" -H
done

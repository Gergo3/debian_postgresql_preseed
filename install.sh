#!/bin/sh

set +x

echo 'Running final installer scripts'

for f in /cdrom/preseed/install.d/*.sh; do
    echo "Running $f ..."

    /bin/sh "$f" -H
done

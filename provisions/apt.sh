#If our cache is older than a day
if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 86400 ]; then
  apt-get update
fi


all: convert manifest

convert:
	sh etc/convert.sh
manifest:
	perl etc/manifest.pl


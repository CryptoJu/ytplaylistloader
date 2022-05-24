#! /bin/bash

echo "Welcome to CryptoJu's Youtube Playlist Downloader"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Checks if Youtube DL Library is installed and if not, installs it
if [ $(dpkg-query -W -f='${Status}' youtube-dl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "Downloading required package youtube_dl"
	pip install --upgrade youtube-dl
fi

# Reads every line of the textfile and assigns variables for url and name
while IFS=';' read -r p n; do
	playlist+=( "$p" )
	name+=( "$n" )
done < playlists.txt

# Downloads playlist with youtube dl and creates a folder for it
for i in "${name[@]}"
do
	echo "Downloading playlist $i. Creating directory...."
	mkdir -p $i
	cd $i
	youtube-dl --extract-audio --audio-format mp3 -i -o "%(title)s.%(ext)s" ${playlist[0]}
	cd ..
	playlist=("${playlist[@]:1}")
done

echo "Die Playlist/s wurde/n fertig heruntergeladen."

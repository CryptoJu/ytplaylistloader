#! /bin/bash
if [ $(dpkg-query -W -f='${Status}' youtube-dl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "Checking if required package Youtube-dl is installed"
	sudo -H pip install --upgrade youtube-dl
fi

echo "###############################################"
echo "So, jetzt kanns losgehen!"
while IFS=' ' read -r p n; do
	playlist+=( "$p" )
	name+=( "$n" )
done < playlists.txt
echo "Reading playlists....."
echo "Playlists loaded. Starting download......"
echo "###############################################"
for i in "${name[@]}"
do
	echo "###############################################"
	echo "Downloading playlist $i. Creating directory...."
	echo "###############################################"
	mkdir -p $i
	cd $i
	youtube-dl --extract-audio --audio-format mp3 -i -o "%(title)s.%(ext)s" ${playlist[0]}
	cd ..
	playlist=("${playlist[@]:1}")
done
echo "############################################"
echo "Finished downloading all specified playlists!"
echo "Thanks for using Spastins Playlistloader. Have a nice day"
echo "############################################"

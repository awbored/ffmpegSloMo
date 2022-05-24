#!/bin/bash

### Universal Variables
slep=30 # Seconds to rest between encodes

### Checking directories
encodeDirectory="./toEncode"
if [ ! -d "$encodeDirectory" ]
  then mkdir $encodeDirectory
fi

exportDirectory="./export"
if [ ! -d "$exportDirectory" ]
  then mkdir $exportDirectory
fi


### Meat and Potatoes
for VIDEO in toEncode/*.mp4;
  do
      ### Name stuff
      NAME1=`echo "${VIDEO}" | cut -d'.' -f1`
      FILE=`echo "${NAME1}" | cut -d'/' -f2`
      NEWFILE="${FILE}-SLO"
      echo "Filename will be ${NEWFILE}"

      sleep 3

      ### Slowing Down Video
      ffmpeg -i "$VIDEO" \
        -vf "setpts=2.0*PTS" "./${exportDirectory}/${NEWFILE}-VID.mkv" < /dev/null
        
      ### Slowing Down Audio
      ffmpeg -i "$VIDEO" \
      	-filter:a "atempo=0.5" -vn "./${exportDirectory}/${NEWFILE}-AUD.wav" < /dev/null
      	
      ### Marrying the two
      ffmpeg \
	-i "./${exportDirectory}/${NEWFILE}-VID.mkv" -i "./${exportDirectory}/${NEWFILE}-AUD.wav" -c:a copy -map 0:v:0 -map 1:a:0 "./${exportDirectory}/${NEWFILE}.mkv"
	
      ### Removing these files because we don't need them
      rm "./${exportDirectory}/${NEWFILE}-VID.mkv"
      rm "./${exportDirectory}/${NEWFILE}-AUD.wav"


      ### Sleep to allow processor to cool down between encodes
      echo "Resting for $slep seconds"
      sleep ${slep}

  done

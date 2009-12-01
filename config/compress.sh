ffmpeg -i test.mov -s 480x360 -acodec mp3 -ac 1 -ar 44100 -b 900 -r 24 -aspect 4:3 -y test.flv
flvtool2 -U test.flv

ffmpeg -i test.mov -s 480x360 -acodec mp3 -ac 1 -ar 22050 -b 1381 -r 18 -aspect 4:3 -y test.flv
flvtool2 -U test.flv

ffmpeg -i test.mov -s 480x360 -acodec mp3 -ac 1 -ar 22050 -b 1300k -r 20 -aspect 4:3 -vcodec flv  -flags +aic+cbp+mv0+mv4+trell -y test.flv 

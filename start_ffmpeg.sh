#!/bin/sh

# Avvio Ngnix in background (demone)
echo "Start Ngnix"
nginx -c /etc/nginx/nginx.conf &

cmd="ffmpeg -i rtsp://${ADDRESS}:${PORT_RTSP}/video -c:a libfdk_aac -b:a 128k -c:v libx264 -b:v 2500k -f flv -g 30 -r 30 -s 1280x720 -preset superfast -profile:v baseline rtmp://localhost:1935/hls/CAM1_720p2628kbs -c:a libfdk_aac -b:a 128k -c:v libx264 -b:v 1000k -f flv -g 30 -r 30 -s 854x480 -preset superfast -profile:v baseline rtmp://localhost:1935/hls/CAM1_480p1128kbs -c:a libfdk_aac -b:a 128k -c:v libx264 -b:v 750k -f flv -g 30 -r 30 -s 640x360 -preset superfast -profile:v baseline rtmp://localhost:1935/hls/CAM1_360p878kbs -c:a libfdk_aac -b:a 128k -c:v libx264 -b:v 400k -f flv -g 30 -r 30 -s 426x240 -preset superfast -profile:v baseline rtmp://localhost:1935/hls/CAM1_240p528kbs -c:a libfdk_aac -b:a 64k -c:v libx264 -b:v 200k -f flv -g 15 -r 15 -s 426x240 -preset superfast -profile:v baseline rtmp://localhost:1935/hls/CAM1_240p264kbs"
until $cmd ; do
        echo "restarting ffmpeg command..."
        sleep 2
done

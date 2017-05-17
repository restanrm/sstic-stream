# SSTIC live streaming docker image

Due to bad internet connexion we have to set a replica of live streaming feed of sstic.

Following their great [guide](http://streaming.sstic.org/#mirrors) for creating a mirror, we have created this docker image to redistribute the streaming.

# run this image

    make run 
or 
    docker run --rm -it -p 80:80 -p 1935:1935 --name sstic-stream restanrm/sstic-stream

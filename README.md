docker-eyeOs (1.9)
===================

docker + apache + mysql + phpadmin + eyeOs(1.9)


# Build image
$ sudo docker build -t jdelacasa/docker-eyeos:1.9 .


#Run image 

$ sudo docker run -d -p 2223:22 -p 12001:80 -p 9001:9001 -v $(pwd)/eyeOS1.9:/var/www jdelacasa/docker-eyeos:1.9

** Fix perm


$ ssh localhost -p 2223 (user:root/pass:Changeme)
$ chown -R www-data /var/www


Ok.

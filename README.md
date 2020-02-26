# parity
The file for virtualbox is an script that prepares 3 hosts to setup on debian
Check the working environment by pulling the image lvrrz/substrate-ok built using the tasks described in the Dockerfile.
docker image pull lvrrz/substrate-ok

The image can be succesfully run with:
docker container run -d lvrrz/substrate-ok /home/alvaro/substrate/substrate/target/release/substrate --port 30333  --telemetry-url ws://telemetry.polkadot.io:1024

it gets monitored in: 
https://telemetry.polkadot.io/#/Flaming%20Fir

The dockerfile encounters the issue
I was not able to solve a problem with vm-driver in kubernetes where docker, none and virtualbox were not working 
so in that part I failed completely.

# parity
The file for virtualbox is an script that prepares 3 hosts to setup on debian

The Dockerfile has ISSUE 4978. The advised solutions didn't solved the problem.

Check the working environment by pulling the image lvrrz/substrate-ok built using the tasks described in the Dockerfile.
docker image pull lvrrz/substrate-ok

The image can be run with:

$
docker container run -d lvrrz/substrate-ok /home/alvaro/substrate/substrate/target/release/substrate --port 30333  --telemetry-url ws://telemetry.polkadot.io:1024
$

it gets monitored in: 
https://telemetry.polkadot.io/#/Flaming%20Fir

Kubernetes
I was not able to solve a problem with vm-driver in kubernetes locally where docker, none (both said unsupported) and virtualbox (cannot find vboxmanage, this one got me lost) were not working when starting it up, so in that part I failed completely.
I have included nevertheless 2 files I was preparing while installing OS in the VMs. Dunno, just for reading I guess as  they are not tested.


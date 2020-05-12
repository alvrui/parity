# parity
The file for virtualbox is an script that prepares 3 hosts to setup on debian

The Dockerfile has ISSUE 4978. The advised solutions didn't solved the problem.
let mem = buf.unchecked_ref::<WebAssembly::Memory>();
     |                                                            ^^^^^^ this struct is private
     
always while compiling js-sys

Check the working environment by pulling the image lvrrz/substrate-ok built using the tasks described in the Dockerfile.
docker image pull lvrrz/substrate-ok:latest

The image can be run with:

docker container run -d lvrrz/substrate-ok /home/alvaro/substrate/substrate/target/release/substrate --port 30333  --telemetry-url ws://telemetry.polkadot.io:1024

it gets monitored in: 
https://telemetry.polkadot.io/#/Flaming%20Fir

Kubernetes
Issue with vm-driver in kubernetes locally where docker, none (both unsupported) and virtualbox (cannot find vboxmanage, this one got me lost) were not working when starting it up.

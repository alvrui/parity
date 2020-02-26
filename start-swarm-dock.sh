#!/bin/bash
countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)
echo ">>Arrancando libraweb......................"
sudo docker run -itd --name lw libraweb
echo "OK"
echo ">>Configurando root........................"
echo -e "secways\nsecways" | sudo docker container exec -i lw passwd
echo "OK"
echo ">>reconfigurarndo ssh server..............."
sudo docker container exec lw sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo docker container exec lw sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
sudo docker container exec lw sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
echo "OK"
echo ">>Inciando ssh............................."
sudo docker container exec lw /etc/init.d/ssh start
echo "OK"
echo ">>Iniciando apache........................."
sudo docker container exec lw /etc/init.d/apache2 start
echo "OK"
echo ">>Creando sesion Librases.................."
sudo docker container exec lw tmux new-session -d -s Librases
echo "OK"
echo ">>Creando pipe de terminal a logLibrases..."
sudo docker container exec lw tmux pipe-pane -t Librases 'cat > /dev/pts/0 > /dev/pts/1 > /var/www/html/logLibrases'
echo "OK"
echo ">>Arrancando swarm........................."
sudo docker container exec lw tmux send-keys -t Librases "./run-swarm.sh" Enter
countdown "00:00:40"
echo "OK"
echo ">>Creado una cuenta de prueba.............."
sudo docker container exec lw tmux send-keys -t Librases "account create" Enter
echo "OK"
sudo docker container exec lw tail /var/www/html/logLibrases
echo "Terminado correctamente...................."

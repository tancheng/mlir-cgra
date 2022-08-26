#!/bin/bash

BAMBUDIR=output/$1
pushd $BAMBUDIR

# F_GROUP_NAME=`stat -c "%G" $(pwd)`
# F_GROUP_ID=`cut -d: -f3 < <(getent group $F_GROUP_NAME)`
# docker run -u `id -u`:$F_GROUP_ID -v $PWD:/Panda-flow -it --rm panda_openroad:latest 

docker run -u $(id -u):$(id -g) -v $PWD:/Panda-flow --rm panda_openroad:latest \
  /bin/bash /Panda-flow/synthesize_Synthesis_main_kernel.sh

popd
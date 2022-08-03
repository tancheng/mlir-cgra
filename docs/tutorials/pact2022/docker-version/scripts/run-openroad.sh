#!/bin/bash

BAMBUDIR=output/$1
pushd $BAMBUDIR

# F_GROUP_NAME=`stat -c "%G" $(pwd)`
# F_GROUP_ID=`cut -d: -f3 < <(getent group $F_GROUP_NAME)`
# docker run -u `id -u`:$F_GROUP_ID -v $PWD:/Panda-flow -it --rm panda_openroad:latest 

# docker run -u $(id -u):$(id -g) -v $PWD:/Panda-flow -v $PWD:/working_dir --rm agostini01/panda_openroad:latest \

docker run -u $(id -u):$(id -g) -v $PWD:/working_dir --rm agostini01/soda:latest \
/bin/bash /working_dir/synthesize_Synthesis_main_kernel.sh

popd
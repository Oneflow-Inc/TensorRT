export TENSORRT_RELEASE_DIR=$1
if [ ! -d "$TENSORRT_RELEASE_DIR" ]; then
  mkdir $TENSORRT_RELEASE_DIR
fi
tar xzvf /dataset/tensorrt/TensorRT-6.0.1.5.Ubuntu-18.04.x86_64-gnu.cuda-10.0.cudnn7.6.tar.gz -C $TENSORRT_RELEASE_DIR
export TRT_RELEASE=$TENSORRT_RELEASE_DIR/TensorRT-6.0.1.5
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_RELEASE/lib
cd $TRT_RELEASE/python && pip3 install tensorrt-6.0.1.5-cp36-none-linux_x86_64.whl
cd $TRT_RELEASE/uff && pip3 install uff-0.6.5-py2.py3-none-any.whl
cd $TRT_RELEASE/graphsurgeon && pip3 install graphsurgeon-0.4.1-py2.py3-none-any.whl

### 安装TensorRT Release
* 根据Python版本修改install_trt.sh第8行代码，支持Python版本有：27, 34, 35, 36, 37，默认为36；
* 指定TensorRT Release安装目录；

例子：sh install_trt.sh /tmp/tensorrt_release

### 编译TensorRT工程以及mnist demo测试
设置环境变量：
```bash
export $TRT_RELEASE=TensorRT Release安装目录，例如：/tmp/tensorrt_release/TensorRT-6.0.1.5
export $TRT_SOURCE=TensorRT工程目录，例如：~/repos/TensorRT
```

15服务器gcc以及标准库版本较低，所以需要在docker中进行编译，选择Ubuntu-18.04的Dockerfile。
```bash
docker build -f $TRT_SOURCE/docker/ubuntu-18.04.Dockerfile --build-arg CUDA_VERSION=10.0 --tag=tensorrt .
nvidia-docker run -v $TRT_RELEASE:/tensorrt -v $TRT_SOURCE:/workspace/TensorRT -it tensorrt:latest
```

#### 编译TensorRT工程
```bash
cd $TRT_SOURCE
mkdir -p build && cd build 
cmake .. -DTRT_LIB_DIR=$TRT_RELEASE/lib -DTRT_BIN_DIR=`pwd`/out
make -j$(nproc)
```

#### mnist demo测试
在docker外准备mnist测试数据：
```bash
cp /dataset/tensorrt/mnist/*.pgm $TRT_RELEASE/data/mnist
```
在docker内部跑demo：
```bash
export LD_LIBRARY_PATH=$TRT_SOURCE/build/out:$LD_LIBRARY_PATH
cd $TRT_SOURCE/build/out/
./sample_mnist --datadir=$TRT_RELEASE/data/mnist
```

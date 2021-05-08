NVCC=nvcc
NVCCFLAGS=-std=c++11 -arch=sm_80 -lcublas
# To enable CULiP profiler, uncomment this line
# To install CULiP Profiler, see this link (https://github.com/enp1s0/CULiP)
#NVCCFLAGS=-std=c++11 -arch=sm_80 -lculip_cublas -lcublas
TARGET=cuda-umem-test

$(TARGET):src/main.cu
	$(NVCC) $< -o $@ $(NVCCFLAGS)

clean:
	rm -f $(TARGET)

NVCC=nvcc
NVCCFLAGS=-std=c++11 -arch=sm_80 -lcublas
TARGET=cuda-umem-test

$(TARGET):src/main.cu
	$(NVCC) $< -o $@ $(NVCCFLAGS)

clean:
	rm -f $(TARGET)

# CUDA Managed memory test

## Usage
```bash
make
./cuda-umem-test
```

## Result

```
Matrix size : 32768 x 32768
[ mem] 661933us
[umem] 61247415us
```

### CULiP Result
- Device memory
```
#####################################
#       CULiP Profiling Result      #
#  https://github.com/enp1s0/CULiP  #
#####################################

- cublasSgemm_v2 : [5264 ns; 5.264000e-06 s;100.00%]
                params    count                   sum          avg          max          min
  m32768-n32768-k32768        4      0.005ms(100.00%)      0.001ms      0.004ms      0.000ms
```

- Unifyed memory
```
#####################################
#       CULiP Profiling Result      #
#  https://github.com/enp1s0/CULiP  #
#####################################

- cublasSgemm_v2 : [61247343327 ns; 6.124734e+01 s;100.00%]
                params    count                   sum          avg          max          min
  m32768-n32768-k32768        4  61247.343ms(100.00%)  15311.836ms  15363.631ms  15263.454ms
```

### Test environment
- RTX 3080

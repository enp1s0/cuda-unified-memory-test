# CUDA Managed memory test

## Usage
```bash
make
./cuda-umem-test
```

## Result

```
Matrix size : 16384 x 16384
[umem] 2255408us // cudaMemcpy H2D + cublasSgemm
[ mem] 2233257us // (implicit cudaMemcpy HtoD) + cublasSgemm
```

### CULiP Result
- Device memory
```
#####################################
#       CULiP Profiling Result      #
#  https://github.com/enp1s0/CULiP  #
#####################################

- cublasSgemm_v2 : [2000953373 ns; 2.000953e+00 s;100.00%]
                params    count                   sum          avg          max          min
  m16384-n16384-k16384        4   2000.953ms(100.00%)    500.238ms    501.305ms    497.164ms
```

- Unifyed memory
```
#####################################
#       CULiP Profiling Result      #
#  https://github.com/enp1s0/CULiP  #
#####################################

- cublasSgemm_v2 : [2256737639 ns; 2.256738e+00 s;100.00%]
                params    count                   sum          avg          max          min
  m16384-n16384-k16384        4   2256.738ms(100.00%)    564.184ms    767.031ms    496.519ms
```

### Test environment
- NVIDIA RTX 3080
- Intel(R) Xeon(R) E-2136 CPU @ 3.30GHz
- DDR4 2666MHz

#### Detail 
- GPU
```
==============NVSMI LOG==============

Timestamp                                 : Sat May  8 16:07:22 2021
Driver Version                            : 465.19.01
CUDA Version                              : 11.3

Attached GPUs                             : 1
GPU 00000000:01:00.0
    Product Name                          : NVIDIA GeForce RTX 3080
    Product Brand                         : GeForce
    Display Mode                          : Disabled
    Display Active                        : Disabled
    Persistence Mode                      : Disabled
    MIG Mode
        Current                           : N/A
        Pending                           : N/A
    Accounting Mode                       : Disabled
    Accounting Mode Buffer Size           : 4000
    Driver Model
        Current                           : N/A
        Pending                           : N/A
    Serial Number                         : N/A
    GPU UUID                              : GPU-82b28e35-d37f-db4a-3538-81465ac446ed
    Minor Number                          : 0
    VBIOS Version                         : 94.02.26.40.95
    MultiGPU Board                        : No
    Board ID                              : 0x100
    GPU Part Number                       : N/A
    Inforom Version
        Image Version                     : G001.0000.03.03
        OEM Object                        : 2.0
        ECC Object                        : N/A
        Power Management Object           : N/A
    GPU Operation Mode
        Current                           : N/A
        Pending                           : N/A
    GPU Virtualization Mode
        Virtualization Mode               : None
        Host VGPU Mode                    : N/A
    IBMNPU
        Relaxed Ordering Mode             : N/A
    PCI
        Bus                               : 0x01
        Device                            : 0x00
        Domain                            : 0x0000
        Device Id                         : 0x220610DE
        Bus Id                            : 00000000:01:00.0
        Sub System Id                     : 0x161219DA
        GPU Link Info
            PCIe Generation
                Max                       : 3
                Current                   : 1
            Link Width
                Max                       : 16x
                Current                   : 16x
        Bridge Chip
            Type                          : N/A
            Firmware                      : N/A
        Replays Since Reset               : 0
        Replay Number Rollovers           : 0
        Tx Throughput                     : 0 KB/s
        Rx Throughput                     : 0 KB/s
    Fan Speed                             : 0 %
    Performance State                     : P8
    Clocks Throttle Reasons
        Idle                              : Active
        Applications Clocks Setting       : Not Active
        SW Power Cap                      : Not Active
        HW Slowdown                       : Not Active
            HW Thermal Slowdown           : Not Active
            HW Power Brake Slowdown       : Not Active
        Sync Boost                        : Not Active
        SW Thermal Slowdown               : Not Active
        Display Clock Setting             : Not Active
    FB Memory Usage
        Total                             : 10015 MiB
        Used                              : 0 MiB
        Free                              : 10015 MiB
    BAR1 Memory Usage
        Total                             : 256 MiB
        Used                              : 4 MiB
        Free                              : 252 MiB
    Compute Mode                          : Default
    Utilization
        Gpu                               : 0 %
        Memory                            : 2 %
        Encoder                           : 0 %
        Decoder                           : 0 %
    Encoder Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    FBC Stats
        Active Sessions                   : 0
        Average FPS                       : 0
        Average Latency                   : 0
    Ecc Mode
        Current                           : N/A
        Pending                           : N/A
    ECC Errors
        Volatile
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
        Aggregate
            SRAM Correctable              : N/A
            SRAM Uncorrectable            : N/A
            DRAM Correctable              : N/A
            DRAM Uncorrectable            : N/A
    Retired Pages
        Single Bit ECC                    : N/A
        Double Bit ECC                    : N/A
        Pending Page Blacklist            : N/A
    Remapped Rows                         : N/A
    Temperature
        GPU Current Temp                  : 46 C
        GPU Shutdown Temp                 : 98 C
        GPU Slowdown Temp                 : 95 C
        GPU Max Operating Temp            : 93 C
        GPU Target Temperature            : 83 C
        Memory Current Temp               : N/A
        Memory Max Operating Temp         : N/A
    Power Readings
        Power Management                  : Supported
        Power Draw                        : 13.42 W
        Power Limit                       : 320.00 W
        Default Power Limit               : 320.00 W
        Enforced Power Limit              : 320.00 W
        Min Power Limit                   : 100.00 W
        Max Power Limit                   : 336.00 W
    Clocks
        Graphics                          : 0 MHz
        SM                                : 0 MHz
        Memory                            : 405 MHz
        Video                             : 555 MHz
    Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Default Applications Clocks
        Graphics                          : N/A
        Memory                            : N/A
    Max Clocks
        Graphics                          : 2100 MHz
        SM                                : 2100 MHz
        Memory                            : 9501 MHz
        Video                             : 1950 MHz
    Max Customer Boost Clocks
        Graphics                          : N/A
    Clock Policy
        Auto Boost                        : N/A
        Auto Boost Default                : N/A
    Processes                             : None
```

- RAM
```
# dmidecode 3.2
Getting SMBIOS data from sysfs.
SMBIOS 3.1.1 present.

Handle 0x0040, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8 GB
	Form Factor: DIMM
	Set: None
	Locator: ChannelA-DIMM1
	Bank Locator: BANK 0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Team Group Inc.
	Serial Number: 0104D5EF
	Asset Tag: 9876543210
	Part Number: TEAMGROUP-UD4-2666
	Rank: 1
	Configured Memory Speed: 2666 MT/s
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: 1.2 V

Handle 0x0041, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: ChannelA-DIMM2
	Bank Locator: BANK 1
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Team Group Inc.
	Serial Number: 0104834A
	Asset Tag: 9876543210
	Part Number: TEAMGROUP-UD4-2666
	Rank: 2
	Configured Memory Speed: 2666 MT/s
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: 1.2 V

Handle 0x0042, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8 GB
	Form Factor: DIMM
	Set: None
	Locator: ChannelB-DIMM1
	Bank Locator: BANK 2
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Team Group Inc.
	Serial Number: 0104D005
	Asset Tag: 9876543210
	Part Number: TEAMGROUP-UD4-2666
	Rank: 1
	Configured Memory Speed: 2666 MT/s
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: 1.2 V

Handle 0x0043, DMI type 17, 40 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: ChannelB-DIMM2
	Bank Locator: BANK 3
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2666 MT/s
	Manufacturer: Team Group Inc.
	Serial Number: 0104837C
	Asset Tag: 9876543210
	Part Number: TEAMGROUP-UD4-2666
	Rank: 2
	Configured Memory Speed: 2666 MT/s
	Minimum Voltage: Unknown
	Maximum Voltage: Unknown
	Configured Voltage: 1.2 V
```

- CPU

```
processors  : 0 - 11
vendor_id	: GenuineIntel
cpu family	: 6
model		: 158
model name	: Intel(R) Xeon(R) E-2136 CPU @ 3.30GHz
stepping	: 10
microcode	: 0xde
cpu MHz		: 4304.433
cache size	: 12288 KB
physical id	: 0
siblings	: 12
core id		: 5
cpu cores	: 6
apicid		: 11
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_clear flush_l1d
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit srbds
bogomips	: 6624.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:
```

# License
MIT

#cross-language-reading-speed

# IMPORTANT
```
ADD in /etc/environment use sudo

export FILE_NAME_LIST_FILES="/home/usuario/outfiles/output"
export FILE_NAME_LOG="/home/usuario/execution-times.txt"
```

## Machine description and OS
```
System:
  Host: usuario Kernel: 6.14.0-24-generic arch: x86_64 bits: 64
  Desktop: KDE Plasma v: 5.27.12 Distro: Kubuntu 24.04.2 LTS (Noble Numbat)
Machine:
  Type: Laptop System: Dell product: Latitude 5410 v: N/A
    serial: <superuser required>
  Mobo: Dell model: 08NM43 v: A00 serial: <superuser required> UEFI: Dell
    v: 1.37.1 date: 06/11/2025
Battery:
  ID-1: BAT0 charge: 23.6 Wh (100.0%) condition: 23.6/42.0 Wh (56.2%)
CPU:
  Info: quad core model: Intel Core i7-10610U bits: 64 type: MT MCP cache:
    L2: 1024 KiB
  Speed (MHz): avg: 901 min/max: 400/4900 cores: 1: 1200 2: 1200 3: 400
    4: 1200 5: 1215 6: 400 7: 1200 8: 400
Graphics:
  Device-1: Intel CometLake-U GT2 [UHD Graphics] driver: i915 v: kernel
  Device-2: Realtek Integrated_Webcam_HD driver: uvcvideo type: USB
  Display: x11 server: X.Org v: 21.1.11 with: Xwayland v: 23.2.6 driver: X:
    loaded: modesetting unloaded: fbdev,vesa dri: swrast gpu: i915
    resolution: 1920x1080~50Hz
  API: EGL v: 1.5 drivers: swrast platforms: x11,surfaceless,device
  API: OpenGL v: 4.5 vendor: mesa v: 24.2.8-1ubuntu1~24.04.1
    renderer: llvmpipe (LLVM 19.1.1 256 bits)
  API: Vulkan v: 1.3.275 drivers: N/A surfaces: xcb,xlib
Audio:
  Device-1: Intel Comet Lake PCH-LP cAVS driver: snd_hda_intel
  API: ALSA v: k6.14.0-24-generic status: kernel-api
  Server-1: PipeWire v: 1.0.5 status: active
Network:
  Device-1: Intel Comet Lake PCH-LP CNVi WiFi driver: iwlwifi
  IF: wlo1 state: down mac: 5c:cd:5b:d5:58:bd
  Device-2: Intel Ethernet I219-LM driver: e1000e
  IF: eno2 state: up speed: 1000 Mbps duplex: full mac: b0:7b:25:aa:49:25
  IF-ID-1: docker0 state: down mac: 86:ad:c9:b1:f1:74
  IF-ID-2: virbr0 state: down mac: 52:54:00:25:2f:f6
Bluetooth:
  Device-1: Intel AX201 Bluetooth driver: btusb type: USB
  Report: hciconfig ID: hci0 state: up address: 5C:CD:5B:D5:58:C1 bt-v: 5.2
Drives:
  Local Storage: total: 700.51 GiB used: 175.8 GiB (25.1%)
  ID-1: /dev/nvme0n1 vendor: Toshiba model: KBG40ZNS512G NVMe KIOXIA 512GB
    size: 476.94 GiB
  ID-2: /dev/sda vendor: Kingston model: SA400S37240G size: 223.57 GiB
    type: USB
Partition:
  ID-1: / size: 468.09 GiB used: 85.58 GiB (18.3%) fs: ext4
    dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 299.4 MiB used: 6.1 MiB (2.1%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 512 MiB used: 0 KiB (0.0%) file: /swapfile
Sensors:
  System Temperatures: cpu: 46.0 C pch: 42.0 C mobo: N/A
  Fan Speeds (rpm): N/A
Info:
  Memory: total: 32 GiB note: est. available: 30.96 GiB used: 4.14 GiB (13.4%)
  Processes: 308 Uptime: 4h 10m Shell: Zsh inxi: 3.3.34
```

## Languages
.NET 9.0

Assembly (NASM) 2.16.01

C 11

C++ 20

Go 1.22.1

Java 21

Node.js 22.x (JavaScript/TypeScript)

PHP 8.x

Python 3.12

Ruby 3.2.3

Rust 1.88.0

## Tests
```

**********************************************************************
Java Execution Report
Start Time: 10:19:57
End Time: 10:20:02
Execution Duration: 00:00:05
Memory Usage: 17461637120 bytes (16652,71 MB, 16,26 GB)
Free Memory: 15776952320 bytes (15046,07 MB, 14,69 GB)
CPU Time in User Mode: 6090000000 ns
Process CPU Load: 0,00%
Total Records in File: /home/usuario/outfiles/output_java_output.txt
File with Listed Files Total Lines: 915614
Output File Size: 98037832 bytes (93,50 MB, 0,09 GB)
**********************************************************************


**********************************************************************
GO
Start: 10:20:20
End: 10:20:25
Execution time: 00:00:04
CPU usage: 73.85%
Memory RSS: 10080256 bytes (9.61 MB, 0.01 GB)
Memory VMS: 1939148800 bytes (1849.32 MB, 1.81 GB)
File with listed files: /home/usuario/outfiles/outputoutput_go.txt
**********************************************************************


**********************************************************************
Python
Start: 28/07/2025 10:20:42
End: 28/07/2025 10:20:47
Execution time: 5.2410 seconds
CPU usage: 0.0%
CPU time in user mode: 4.63 seconds
CPU time in kernel mode: 0.81 seconds
Memory usage: 35348480 bytes (33.71 MB, 0.03 GB) (RSS)
Percentage of memory used: 0.11%
**********************************************************************


**********************************************************************
Ruby
Start: 10:21:46
End: 10:21:57
Execution time: 00:00:11
Memory usage:
  Bytes: 16990318592
  Megabytes: 16203.23 MB
  Gigabytes: 15.82 GB
CPU time in user mode: 00:00:11
File with listed files: /home/usuario/outfiles/output/output_ruby.txt
**********************************************************************

**********************************************************************
C#
Start: 10:22:58
End: 10:23:05
Execution time: 00:00:06
Memory usage (in bytes): 296222720
Memory usage (in MB): 282.50
Memory usage (in GB): 0.28
Total CPU time: 00:00:06.3470340
CPU time in user mode: 00:00:02.9254690
CPU time in kernel mode: 00:00:03.4215750
File with listed files: /home/usuario/outfiles/output/output_csharp.txt
**********************************************************************
```
**Computing system (please complete the following information):**
 - Machine name [e.g. Archer, My Desktop]: PACE @ Georgia Tech, Atlanta
 - HiDEM commit hash [e.g. 53e2eb5]: 9b91a0f 

**Issue Type**
SEGFAULT

**Error message or symptoms**
Segmentation fault (signal 11)

**Describe the context**
The segmentation fault only occurs when fracture is allowed to initiate. In my modified HiDEM code, I impose a condition where particles within a specific portion of the domain undergo bond breaking and are flushed with some velocity. I use a rectangular domain with fixed lateral and inflow margin boundary conditions with a grid spacing of 5m. I have noticed that segmentation does not occur if I use a particle SCL of 5,4,2m but using a SCL of 3m ends the simulation on fracture initiation due to segmentation. This also seems to be dependent on the amount of processors assigned to the job, i.e. the job does not fail if I use 3 nodes and 28 ppn.

**Expected behavior**
HiDEM should behave normally regardless of particle scale and amount of nodes assigned to the job.

**Error Log**

Program received signal SIGSEGV: Segmentation fault - invalid memory reference.

Backtrace for this error:

Program received signal SIGSEGV: Segmentation fault - invalid memory reference.

Backtrace for this error:

Program received signal SIGSEGV: Segmentation fault - invalid memory reference.

Backtrace for this error:

Program received signal SIGSEGV: Segmentation fault - invalid memory reference.

Backtrace for this error:
#0  0x2aaaac28727f in ???
#0  0x2aaaac28727f in ???
#0  0x2aaaac28727f in ???
#1  0x441dd4 in ???
#2  0x40280e in ???
#3  0x2aaaac2733d4 in ???
#4  0x402837 in ???
#5  0xffffffffffffffff in ???
#1  0x441dd4 in ???
#2  0x40280e in ???
#3  0x2aaaac2733d4 in ???
#4  0x402837 in ???
#5  0xffffffffffffffff in ???
#1  0x441dd4 in ???
#2  0x40280e in ???
#3  0x2aaaac2733d4 in ???
#4  0x402837 in ???
#5  0xffffffffffffffff in ???
#0  0x2aaaac28727f in ???
#1  0x441dd4 in ???
#2  0x40280e in ???
#3  0x2aaaac2733d4 in ???
#4  0x402837 in ???
#5  0xffffffffffffffff in ???


**Any suspicions/clues as to what the cause might be?**
Potentially something to do with the amount of processors involved compared to the aprticle scale, however, I don't know why it would be the case that segmentation only occurs as soon as fracture is permitted.

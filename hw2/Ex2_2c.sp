.TITLE Ex2_2c DCVS_full_adder

.protect
.include "7nm_TT.pm"
.unprotect

.VEC "Pattern_adder_1bit_001.vec"

.temp 25 
.option post runlvl=6 captable

******************************
.SUBCKT inverter in out VDD VSS
Mp  out  in  VDD  VDD  pmos_rvt W=7n L=7n nFin=1
Mn  out  in  VSS  VSS  nmos_rvt W=7n L=7n nFin=1
.ENDS
******************************
.SUBCKT buffer in out VDD VSS
X_INV1 in   in_b VDD VSS inverter
X_INV2 in_b out  VDD VSS inverter
.ENDS
******************************
.SUBCKT DCVS_full_adder Ain Bin Cin CARRY CARRY_BAR SUM SUM_BAR VDD VSS
*.PININFO A:I B:I C:I CARRY:O CARRY_BAR:O SUM:O SUM_BAR:O VDD:B VSS:B
Xbuffer_A  Ain  A VDD VSS buffer
Xbuffer_B  Bin  B VDD VSS buffer
Xbuffer_C  Cin  C VDD VSS buffer
MM36 C_BAR C VDD VDD pmos_rvt W=7n L=7n m=5
MM34 B_BAR B VDD VDD pmos_rvt W=7n L=7n m=5
MM33 A_BAR A VDD VDD pmos_rvt W=7n L=7n m=5
MM23 SUM_BAR SUM VDD VDD pmos_rvt W=7n L=7n m=5
MM22 SUM SUM_BAR VDD VDD pmos_rvt W=7n L=7n m=5
MM1 CARRY_BAR CARRY VDD VDD pmos_rvt W=7n L=7n m=5
MM0 CARRY CARRY_BAR VDD VDD pmos_rvt W=7n L=7n m=4
MM37 C_BAR C VSS VSS nmos_rvt W=7n L=7n m=4
MM35 B_BAR B VSS VSS nmos_rvt W=7n L=7n m=4
MM32 A_BAR A VSS VSS nmos_rvt W=7n L=7n m=4
MM21 net8 C_BAR VSS VSS nmos_rvt W=7n L=7n m=4
MM20 net5 B_BAR net8 VSS nmos_rvt W=7n L=7n m=30
MM19 net7 B net8 VSS nmos_rvt W=7n L=7n m=30
MM18 SUM A net7 VSS nmos_rvt W=7n L=7n m=20
MM17 SUM_BAR A_BAR net7 VSS nmos_rvt W=7n L=7n m=20
MM16 net7 B_BAR net6 VSS nmos_rvt W=7n L=7n m=20
MM15 SUM A_BAR net5 VSS nmos_rvt W=7n L=7n m=30
MM14 net6 C VSS VSS nmos_rvt W=7n L=7n m=5
MM13 net5 B net6 VSS nmos_rvt W=7n L=7n m=20
MM12 SUM_BAR A net5 VSS nmos_rvt W=7n L=7n m=20
MM11 net4 C_BAR VSS VSS nmos_rvt W=7n L=7n m=20
MM10 net3 B_BAR VSS VSS nmos_rvt W=7n L=7n m=20
MM9 net3 C_BAR VSS VSS nmos_rvt W=7n L=7n m=20
MM8 CARRY B_BAR net4 VSS nmos_rvt W=7n L=7n m=20
MM7 CARRY A_BAR net3 VSS nmos_rvt W=7n L=7n m=20
MM6 net1 C VSS VSS nmos_rvt W=7n L=7n m=20
MM5 net1 B VSS VSS nmos_rvt W=7n L=7n m=20
MM4 net2 C VSS VSS nmos_rvt W=7n L=7n m=20
MM3 CARRY_BAR B net2 VSS nmos_rvt W=7n L=7n m=20
MM2 CARRY_BAR A net1 VSS nmos_rvt W=7n L=7n m=20
CC0  SUM       VSS 5f
CC1  CARRY     VSS 5f
CC2  SUM_BAR   VSS 5f
CC3  CARRY_BAR VSS 5f
.ENDS
********************************************************

***********************************************************

***********************************************************
X3 Ain Bin Cin CARRY CARRY_BAR SUM SUM_BAR VDD VSS DCVS_full_adder 
* VAin   Ain    GND  pulse 0.0 0.7 1.95u 0.05u 0.05u 1.95u 4u
* VBin   Bin    GND  pulse 0.0 0.7 0.95u 0.05u 0.05u 0.95u 2u
* VCin   Cin    GND  pulse 0.0 0.7 0.45u 0.05u 0.05u 0.45u 1u
* VAin   Ain    GND  pulse 0.0 0.7 0p 0p 0p 0.7n 1.4n
* VBin   Bin    GND  pulse 0.0 0.7 0p 0p 0p 0.4n 0.8n
* VCin   Cin    GND  pulse 0.0 0.7 0p 0p 0p 0.4n 0.8n
VDD  VDD  GND  0.7
VSS  VSS  GND  0.0
***********************************************************
.op
* .tran 1n 4u
.tran 0.1ps 6ns
* .measure TRAN Tp1 TRIG V(Bin) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=1
//000 to start
*000 -> 001
.measure TRAN Tp1 TRIG V(Cin) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=1  
*001 -> 000
.measure TRAN Tp2 TRIG V(Cin) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=1

*000 -> 010
.measure TRAN Tp3 TRIG V(Bin) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=2  
*010 -> 000
.measure TRAN Tp4 TRIG V(Bin) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=2

*000 -> 011
.measure TRAN Tp5 TRIG V(Bin) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=1  
*011 -> 000
.measure TRAN Tp6 TRIG V(Bin) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=1

*000 -> 100
.measure TRAN Tp7 TRIG V(Ain) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=3  
*100 -> 000
.measure TRAN Tp8 TRIG V(Ain) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=3

*000 -> 101
.measure TRAN Tp9 TRIG V(Ain) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=2  
*101 -> 000
.measure TRAN Tp10 TRIG V(Ain) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=2

*000 -> 110
.measure TRAN Tp11 TRIG V(Ain) VAL=0.35 RISE=3 TARG V(CARRY) VAL=0.35 RISE=3  
*110 -> 000
.measure TRAN Tp12 TRIG V(Ain) VAL=0.35 FALL=3 TARG V(CARRY) VAL=0.35 FALL=3

*000 -> 111
.measure TRAN Tp13 TRIG V(Ain) VAL=0.35 RISE=4 TARG V(CARRY) VAL=0.35 RISE=4  
*111 -> 000
.measure TRAN Tp14 TRIG V(Ain) VAL=0.35 FALL=4 TARG V(CARRY) VAL=0.35 FALL=4


//001 to start
*001 -> 010
.measure TRAN Tp15 TRIG V(Bin) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=3 
*010 -> 001
.measure TRAN Tp16 TRIG V(Bin) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=3

*001 -> 011
.measure TRAN Tp17 TRIG V(Bin) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=1 
*011 -> 001
.measure TRAN Tp18 TRIG V(Bin) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=1

*001 -> 100
.measure TRAN Tp19 TRIG V(Ain) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=4 
*100 -> 001
.measure TRAN Tp20 TRIG V(Ain) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=4

*001 -> 101
.measure TRAN Tp21 TRIG V(Ain) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=2 
*101 -> 001
.measure TRAN Tp22 TRIG V(Ain) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=2

*001 -> 110
.measure TRAN Tp23 TRIG V(Ain) VAL=0.35 RISE=3 TARG V(CARRY) VAL=0.35 RISE=3 
*110 -> 001
.measure TRAN Tp24 TRIG V(Ain) VAL=0.35 FALL=3 TARG V(CARRY) VAL=0.35 FALL=3

*001 -> 111
.measure TRAN Tp25 TRIG V(Ain) VAL=0.35 RISE=4 TARG V(CARRY) VAL=0.35 RISE=4 
*111 -> 001
.measure TRAN Tp26 TRIG V(Ain) VAL=0.35 FALL=4 TARG V(CARRY) VAL=0.35 FALL=4


//010 to start
*010 -> 011
.measure TRAN Tp27 TRIG V(Cin) VAL=0.35 RISE=1 TARG V(CARRY) VAL=0.35 RISE=1 
*011 -> 010
.measure TRAN Tp28 TRIG V(Cin) VAL=0.35 FALL=1 TARG V(CARRY) VAL=0.35 FALL=1

*010 ->100 no delay to measure
*010 -> 101
.measure TRAN Tp29 TRIG V(Cin) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=2 
*101 -> 010
.measure TRAN Tp30 TRIG V(Cin) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=2

*010 -> 110
.measure TRAN Tp31 TRIG V(Ain) VAL=0.35 RISE=3 TARG V(CARRY) VAL=0.35 RISE=3 
*110 -> 010
.measure TRAN Tp32 TRIG V(Ain) VAL=0.35 FALL=3 TARG V(CARRY) VAL=0.35 FALL=3

*010 -> 111
.measure TRAN Tp33 TRIG V(Ain) VAL=0.35 RISE=4 TARG V(CARRY) VAL=0.35 RISE=4 
*111 -> 010
.measure TRAN Tp34 TRIG V(Ain) VAL=0.35 FALL=4 TARG V(CARRY) VAL=0.35 FALL=4



//011 to start
*011 -> 100
.measure TRAN Tp35 TRIG V(Ain) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=1 
*100 -> 011
.measure TRAN Tp36 TRIG V(Ain) VAL=0.35 FALL=1 TARG V(SUM) VAL=0.35 FALL=1

*011 -> 101  no delay to measure
*101 -> 011  no delay to measure
*011 -> 110  no delay to measure
*110 -> 011  no delay to measure

*011 -> 111
.measure TRAN Tp37 TRIG V(Ain) VAL=0.35 RISE=4 TARG V(SUM) VAL=0.35 RISE=2 
*110 -> 111
.measure TRAN Tp38 TRIG V(Ain) VAL=0.35 FALL=4 TARG V(SUM) VAL=0.35 FALL=2



//100 to start
*100 -> 101
.measure TRAN Tp39 TRIG V(Cin) VAL=0.35 RISE=1 TARG V(CARRY) VAL=0.35 RISE=1 
*101 -> 100
.measure TRAN Tp40 TRIG V(Cin) VAL=0.35 FALL=1 TARG V(CARRY) VAL=0.35 FALL=1

*100 -> 110
.measure TRAN Tp41 TRIG V(Bin) VAL=0.35 RISE=1 TARG V(CARRY) VAL=0.35 RISE=2 
*110 -> 100
.measure TRAN Tp42 TRIG V(Bin) VAL=0.35 FALL=1 TARG V(CARRY) VAL=0.35 FALL=2

*100 -> 111
.measure TRAN Tp43 TRIG V(Bin) VAL=0.35 RISE=2 TARG V(CARRY) VAL=0.35 RISE=3 
*111 -> 100
.measure TRAN Tp44 TRIG V(Bin) VAL=0.35 FALL=2 TARG V(CARRY) VAL=0.35 FALL=3


//101 to start 
*101 -> 110 no delay to measure
*110 -> 101 no delay to measure

*101 -> 111 
.measure TRAN Tp45 TRIG V(Bin) VAL=0.35 RISE=4 TARG V(SUM) VAL=0.35 RISE=3 
*111 -> 101
.measure TRAN Tp46 TRIG V(Bin) VAL=0.35 FALL=4 TARG V(SUM) VAL=0.35 FALL=4



//110 to start
*110 -> 111
.measure TRAN Tp47 TRIG V(Cin) VAL=0.35 RISE=5 TARG V(SUM) VAL=0.35 RISE=4 
*111 -> 110
.measure TRAN Tp48 TRIG V(Cin) VAL=0.35 FALL=5 TARG V(SUM) VAL=0.35 FALL=5

.measure tran Static_pwr avg POWER 

.end

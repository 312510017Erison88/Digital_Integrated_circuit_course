.TITLE Ex2_2b CPL_full_adder

*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include 'asap7_75t_R_24.cdl'
.unprotect

.VEC "Pattern_adder_1bit.vec"

*****************************
**     Voltage Source      **
*****************************
.global VDD VSS
Vvdd VDD GND 0.7v
Vvss VSS GND 0

.SUBCKT inverter in out VDD VSS
    Mp1 out in VDD x pmos_lvt m=1
    Mn1 out in VSS x nmos_lvt m=1
.ENDS

.subckt buffer in out VDD VSS
	X_INV1 in  in_b VDD VSS inverter
	X_INV2 in_b out VDD VSS inverter
.ends

******************************************
**      Your Circuit  (1-bit adder)     **
******************************************
.SUBCKT CPL_full_adder Ain Bin Cin CARRY CARRY_BAR SUM SUM_BAR VDD VSS
*.PININFO A:I B:I C:I CARRY:O CARRY_BAR:O SUM:O SUM_BAR:O VDD:B VSS:B
Xbuffer_A  Ain  A VDD VSS buffer
Xbuffer_B  Bin  B VDD VSS buffer
Xbuffer_C  Cin  C VDD VSS buffer
MM37 C_BAR C VSS VSS nmos_rvt W=7n L=7n m=1
MM35 B_BAR B VSS VSS nmos_rvt W=7n L=7n m=1
MM32 A_BAR A VSS VSS nmos_rvt W=7n L=7n m=1
MM30 CARRY net1 VSS VSS nmos_rvt W=7n L=7n m=1
MM26 CARRY_BAR VDD VSS VSS nmos_rvt W=7n L=7n m=1
MM24 SUM net9 VSS VSS nmos_rvt W=7n L=7n m=1
MM20 SUM_BAR net8 VSS VSS nmos_rvt W=7n L=7n m=1
MM19 net1 C net4 VSS nmos_rvt W=7n L=7n m=1
MM18 net5 A_BAR VDD VSS nmos_rvt W=7n L=7n m=1
MM17 net4 A_BAR B_BAR VSS nmos_rvt W=7n L=7n m=1
MM16 net1 C_BAR net5 VSS nmos_rvt W=7n L=7n m=1
MM15 net5 A B_BAR VSS nmos_rvt W=7n L=7n m=1
MM14 net4 A VSS VSS nmos_rvt W=7n L=7n m=1
MM13 VDD C net3 VSS nmos_rvt W=7n L=7n m=1
MM12 net3 A_BAR B VSS nmos_rvt W=7n L=7n m=1
MM11 net2 A_BAR VSS VSS nmos_rvt W=7n L=7n m=1
MM10 VDD C_BAR net2 VSS nmos_rvt W=7n L=7n m=1
MM9 net3 A VDD VSS nmos_rvt W=7n L=7n m=1
MM8 net2 A B VSS nmos_rvt W=7n L=7n m=1
MM7 net9 C_BAR net7 VSS nmos_rvt W=7n L=7n m=1
MM6 net9 C net6 VSS nmos_rvt W=7n L=7n m=1
MM5 net8 C net7 VSS nmos_rvt W=7n L=7n m=1
MM4 net8 C_BAR net6 VSS nmos_rvt W=7n L=7n m=1
MM3 net7 A_BAR B_BAR VSS nmos_rvt W=7n L=7n m=1
MM2 net7 A B VSS nmos_rvt W=7n L=7n m=1
MM1 net6 A_BAR B VSS nmos_rvt W=7n L=7n m=1
MM0 net6 A B_BAR VSS nmos_rvt W=7n L=7n m=1
MM36 C_BAR C VDD VDD pmos_rvt W=7n L=7n m=1
MM34 B_BAR B VDD VDD pmos_rvt W=7n L=7n m=1
MM33 A_BAR A VDD VDD pmos_rvt W=7n L=7n m=1
MM31 CARRY net1 VDD VDD pmos_rvt W=7n L=7n m=1
MM29 CARRY_BAR VDD VDD VDD pmos_rvt W=7n L=7n m=1
MM28 net1 VDD VDD VDD pmos_rvt W=7n L=7n m=1
MM27 VDD net1 VDD VDD pmos_rvt W=7n L=7n m=1
MM25 SUM net9 VDD VDD pmos_rvt W=7n L=7n m=1
MM23 SUM_BAR net8 VDD VDD pmos_rvt W=7n L=7n m=1
MM22 net9 net8 VDD VDD pmos_rvt W=7n L=7n m=1
MM21 net8 net9 VDD VDD pmos_rvt W=7n L=7n m=1
CC0  SUM       VSS 5f
CC1  CARRY     VSS 5f
CC2  SUM_BAR   VSS 5f
CC3  CARRY_BAR VSS 5f
.ENDS
*****************************************
* VAin   Ain    GND  pulse 0.0 0.7 1.95u 0.05u 0.05u 1.95u 4u
* VBin   Bin    GND  pulse 0.0 0.7 0.95u 0.05u 0.05u 0.95u 2u
* VCin   Cin    GND  pulse 0.0 0.7 0.45u 0.05u 0.05u 0.45u 1u
XCPL_full_adder Ain Bin Cin CARRY CARRY_BAR SUM SUM_BAR VDD VSS CPL_full_adder

*********Outputs (please note the name of the output ports)******************
* Cload1 COUT_BAR VSS 5f
* Cload2 SUM_BAR VSS 5f
*****************************************************************************
* .tran 1n 4u
.tran 0.1ps 8ns
* .measure TRAN Tp1 TRIG V(Cin) VAL=0.35 RISE=1 TARG V(SUM) VAL=0.35 RISE=1
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

.measure TRAN average_power avg power

*****************************
**    Simulator setting    **
*****************************
.op
.option post 
.options probe		
.probe v(*) i(*) v(XAdder_1bit.*)
.TEMP 25


.end

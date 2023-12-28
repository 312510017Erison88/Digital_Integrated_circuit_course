.TITLE Ex2_1a

*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include 'asap7_75t_R_24.cdl'
.unprotect

.VEC "Pattern_adder_1bit_000.vec"
* .VEC "Pattern_adder_1bit_001.vec"
* .VEC "Pattern_adder_1bit_010.vec"
* .VEC "Pattern_adder_1bit_011.vec"
* .VEC "Pattern_adder_1bit_100.vec"

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

*********Inputs(please use these signals as inputs for your desing)*********
Xbuf_A A A_in VDD VSS buffer
Xbuf_B B B_in VDD VSS buffer
Xbuf_C Cin Cin_buf VDD VSS buffer
*************************************

* .ic sum=0 carry_out=0
******************************************
**      Your Circuit  (1-bit adder)     **
******************************************
.SUBCKT Adder_1bit A_in B_in Cin_buf VDD VSS Carry_out Sum 
    XXOR1 A_in B_in VDD VSS XORAB_out XOR2xp5_ASAP7_75t_R
    XXOR2 XORAB_out Cin_buf VDD VSS Sum XOR2xp5_ASAP7_75t_R
    XMAJ A_in B_in Cin_buf VDD VSS Carry_out_inv MAJIxp5_ASAP7_75t_R
    X_inv_carryout Carry_out_inv Carry_out VDD VSS inverter
.ENDS

XAdder_1bit A_in B_in Cin_buf VDD VSS Carry_out Sum  Adder_1bit
*********Outputs (please note the name of the output ports)******************
Cload1 Carry_out VSS 5f
Cload2 Sum VSS 5f
*****************************************************************************
.tran 0.1ps 8ns

//000 to start
*000 -> 001
.measure TRAN Tp1 TRIG V(Cin_buf) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=1  
*001 -> 000
.measure TRAN Tp2 TRIG V(Cin_buf) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=1

*000 -> 010
.measure TRAN Tp3 TRIG V(B_in) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=2  
*010 -> 000
.measure TRAN Tp4 TRIG V(B_in) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=2

*000 -> 011
.measure TRAN Tp5 TRIG V(B_in) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=1  
*011 -> 000
.measure TRAN Tp6 TRIG V(B_in) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=1

*000 -> 100
.measure TRAN Tp7 TRIG V(A_in) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=3  
*100 -> 000
.measure TRAN Tp8 TRIG V(A_in) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=3

*000 -> 101
.measure TRAN Tp9 TRIG V(A_in) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=2  
*101 -> 000
.measure TRAN Tp10 TRIG V(A_in) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=2

*000 -> 110
.measure TRAN Tp11 TRIG V(A_in) VAL=0.35 RISE=3 TARG V(Carry_out) VAL=0.35 RISE=3  
*110 -> 000
.measure TRAN Tp12 TRIG V(A_in) VAL=0.35 FALL=3 TARG V(Carry_out) VAL=0.35 FALL=3

*000 -> 111
.measure TRAN Tp13 TRIG V(A_in) VAL=0.35 RISE=4 TARG V(Carry_out) VAL=0.35 RISE=4  
*111 -> 000
.measure TRAN Tp14 TRIG V(A_in) VAL=0.35 FALL=4 TARG V(Carry_out) VAL=0.35 FALL=4


//001 to start
*001 -> 010
.measure TRAN Tp15 TRIG V(B_in) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=3 
*010 -> 001
.measure TRAN Tp16 TRIG V(B_in) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=3

*001 -> 011
.measure TRAN Tp17 TRIG V(B_in) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=1 
*011 -> 001
.measure TRAN Tp18 TRIG V(B_in) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=1

*001 -> 100
.measure TRAN Tp19 TRIG V(A_in) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=4 
*100 -> 001
.measure TRAN Tp20 TRIG V(A_in) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=4

*001 -> 101
.measure TRAN Tp21 TRIG V(A_in) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=2 
*101 -> 001
.measure TRAN Tp22 TRIG V(A_in) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=2

*001 -> 110
.measure TRAN Tp23 TRIG V(A_in) VAL=0.35 RISE=3 TARG V(Carry_out) VAL=0.35 RISE=3 
*110 -> 001
.measure TRAN Tp24 TRIG V(A_in) VAL=0.35 FALL=3 TARG V(Carry_out) VAL=0.35 FALL=3

*001 -> 111
.measure TRAN Tp25 TRIG V(A_in) VAL=0.35 RISE=4 TARG V(Carry_out) VAL=0.35 RISE=4 
*111 -> 001
.measure TRAN Tp26 TRIG V(A_in) VAL=0.35 FALL=4 TARG V(Carry_out) VAL=0.35 FALL=4


//010 to start
*010 -> 011
.measure TRAN Tp27 TRIG V(Cin_buf) VAL=0.35 RISE=1 TARG V(Carry_out) VAL=0.35 RISE=1 
*011 -> 010
.measure TRAN Tp28 TRIG V(Cin_buf) VAL=0.35 FALL=1 TARG V(Carry_out) VAL=0.35 FALL=1

*010 ->100 no delay to measure
*010 -> 101
.measure TRAN Tp29 TRIG V(Cin_buf) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=2 
*101 -> 010
.measure TRAN Tp30 TRIG V(Cin_buf) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=2

*010 -> 110
.measure TRAN Tp31 TRIG V(A_in) VAL=0.35 RISE=3 TARG V(Carry_out) VAL=0.35 RISE=3 
*110 -> 010
.measure TRAN Tp32 TRIG V(A_in) VAL=0.35 FALL=3 TARG V(Carry_out) VAL=0.35 FALL=3

*010 -> 111
.measure TRAN Tp33 TRIG V(A_in) VAL=0.35 RISE=4 TARG V(Carry_out) VAL=0.35 RISE=4 
*111 -> 010
.measure TRAN Tp34 TRIG V(A_in) VAL=0.35 FALL=4 TARG V(Carry_out) VAL=0.35 FALL=4



//011 to start
*011 -> 100
.measure TRAN Tp35 TRIG V(A_in) VAL=0.35 RISE=1 TARG V(Sum) VAL=0.35 RISE=1 
*100 -> 011
.measure TRAN Tp36 TRIG V(A_in) VAL=0.35 FALL=1 TARG V(Sum) VAL=0.35 FALL=1

*011 -> 101  no delay to measure
*101 -> 011  no delay to measure
*011 -> 110  no delay to measure
*110 -> 011  no delay to measure

*011 -> 111
.measure TRAN Tp37 TRIG V(A_in) VAL=0.35 RISE=4 TARG V(Sum) VAL=0.35 RISE=2 
*110 -> 111
.measure TRAN Tp38 TRIG V(A_in) VAL=0.35 FALL=4 TARG V(Sum) VAL=0.35 FALL=2



//100 to start
*100 -> 101
.measure TRAN Tp39 TRIG V(Cin_buf) VAL=0.35 RISE=1 TARG V(Carry_out) VAL=0.35 RISE=1 
*101 -> 100
.measure TRAN Tp40 TRIG V(Cin_buf) VAL=0.35 FALL=1 TARG V(Carry_out) VAL=0.35 FALL=1

*100 -> 110
.measure TRAN Tp41 TRIG V(B_in) VAL=0.35 RISE=1 TARG V(Carry_out) VAL=0.35 RISE=2 
*110 -> 100
.measure TRAN Tp42 TRIG V(B_in) VAL=0.35 FALL=1 TARG V(Carry_out) VAL=0.35 FALL=2

*100 -> 111
.measure TRAN Tp43 TRIG V(B_in) VAL=0.35 RISE=2 TARG V(Carry_out) VAL=0.35 RISE=3 
*111 -> 100
.measure TRAN Tp44 TRIG V(B_in) VAL=0.35 FALL=2 TARG V(Carry_out) VAL=0.35 FALL=3


//101 to start 
*101 -> 110 no delay to measure
*110 -> 101 no delay to measure

*101 -> 111 
.measure TRAN Tp45 TRIG V(B_in) VAL=0.35 RISE=4 TARG V(Sum) VAL=0.35 RISE=3 
*111 -> 101
.measure TRAN Tp46 TRIG V(B_in) VAL=0.35 FALL=4 TARG V(Sum) VAL=0.35 FALL=4



//110 to start
*110 -> 111
.measure TRAN Tp47 TRIG V(Cin_buf) VAL=0.35 RISE=5 TARG V(Sum) VAL=0.35 RISE=4 
*111 -> 110
.measure TRAN Tp48 TRIG V(Cin_buf) VAL=0.35 FALL=5 TARG V(Sum) VAL=0.35 FALL=5


.measure TRAN average_power avg power

*****************************
**    Simulator setting    **
*****************************
.op
.option post 
*.options probe			*with I/V in .lis
.probe v(*) i(*) v(XAdder_1bit.*)
.TEMP 25


.end
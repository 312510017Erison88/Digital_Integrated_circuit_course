.TITLE Ex2_4a 4bit_full_adder

*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include 'Adder_4bit_SYN_new.sp'
.include 'asap7sc7p5t_SIMPLE_RVT.sp'
.include 'asap7sc7p5t_SEQ_RVT.sp'
.include 'asap7sc7p5t_OA_RVT.sp'
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.include 'asap7sc7p5t_AO_RVT.sp'
.unprotect

.VEC "Pattern_adder_4bit.vec"
* .VEC "Pattern_256_adder_4bit.vec"

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

Xbuffer_A0  A[0] A0 VDD VSS buffer
Xbuffer_A1  A[1] A1 VDD VSS buffer
Xbuffer_A2  A[2] A2 VDD VSS buffer
Xbuffer_A3  A[3] A3 VDD VSS buffer
Xbuffer_B0  B[0] B0 VDD VSS buffer
Xbuffer_B1  B[1] B1 VDD VSS buffer
Xbuffer_B2  B[2] B2 VDD VSS buffer
Xbuffer_B3  B[3] B3 VDD VSS buffer


XAdder_4bit VSS VDD  A3 A2 A1 A0 B3 B2 B1 B0 Output[4] Output[3] Output[2] Output[1] Output[0] Adder_4bit

Cload4 Output[4] VSS 5f
Cload3 Output[3] VSS 5f
Cload2 Output[2] VSS 5f
Cload1 Output[1] VSS 5f
Cload0 Output[0] VSS 5f

// measurement
.tran 0.1ps 14ns

.measure TRAN Tpd0 TRIG V(b[0]) VAL=0.35 RISE=1 TARG V(Output[4]) VAL=0.35 RISE=1
*.measure TRAN Tplh0 TRIG V(b[0]) VAL=0.35 FALL=1 TARG V(Output[4]) VAL=0.35 FALL=1

.measure TRAN Tpd1 TRIG V(b[0]) VAL=0.35 RISE=2 TARG V(Output[4]) VAL=0.35 RISE=2
*.measure TRAN Tplh1 TRIG V(b[0]) VAL=0.35 FALL=2 TARG V(Output[4]) VAL=0.35 FALL=2

.measure TRAN Tpd2 TRIG V(b[0]) VAL=0.35 RISE=3 TARG V(Output[4]) VAL=0.35 RISE=3
*.measure TRAN Tplh2 TRIG V(b[0]) VAL=0.35 FALL=3 TARG V(Output[4]) VAL=0.35 FALL=3

.measure TRAN Tpd3 TRIG V(b[0]) VAL=0.35 RISE=4 TARG V(Output[4]) VAL=0.35 RISE=4
*.measure TRAN Tplh3 TRIG V(b[0]) VAL=0.35 FALL=4 TARG V(Output[4]) VAL=0.35 FALL=4

.measure TRAN Tpd4 TRIG V(b[0]) VAL=0.35 RISE=5 TARG V(Output[4]) VAL=0.35 RISE=5
*.measure TRAN Tplh4 TRIG V(b[0]) VAL=0.35 FALL=5 TARG V(Output[4]) VAL=0.35 FALL=5

.measure TRAN Tpd5 TRIG V(b[0]) VAL=0.35 RISE=6 TARG V(Output[4]) VAL=0.35 RISE=6
*.measure TRAN Tplh5 TRIG V(b[0]) VAL=0.35 FALL=6 TARG V(Output[4]) VAL=0.35 FALL=6

.measure TRAN Tpd6 TRIG V(b[0]) VAL=0.35 RISE=7 TARG V(Output[4]) VAL=0.35 RISE=7
*.measure TRAN Tplh6 TRIG V(b[0]) VAL=0.35 FALL=7 TARG V(Output[4]) VAL=0.35 FALL=7

.measure TRAN Tpd7 TRIG V(b[0]) VAL=0.35 RISE=8 TARG V(Output[4]) VAL=0.35 RISE=8
*.measure TRAN Tplh7 TRIG V(b[0]) VAL=0.35 FALL=8 TARG V(Output[4]) VAL=0.35 FALL=8

*test
.measure TRAN Tpd8 TRIG V(b[0]) VAL=0.35 RISE=9 TARG V(Output[4]) VAL=0.35 RISE=9
.measure TRAN Tpd9 TRIG V(b[0]) VAL=0.35 RISE=10 TARG V(Output[4]) VAL=0.35 RISE=10
* .measure tran tpd0 param='0.5*(Tphl0+Tplh0)'
* .measure tran tpd1 param='0.5*(Tphl1+Tplh1)'
* .measure tran tpd2 param='0.5*(Tphl2+Tplh2)'
* .measure tran tpd3 param='0.5*(Tphl3+Tplh3)'
* .measure tran tpd4 param='0.5*(Tphl4+Tplh4)'
* .measure tran tpd5 param='0.5*(Tphl5+Tplh5)'
* .measure tran tpd6 param='0.5*(Tphl6+Tplh6)'
* .measure tran tpd7 param='0.5*(Tphl7+Tplh7)'

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
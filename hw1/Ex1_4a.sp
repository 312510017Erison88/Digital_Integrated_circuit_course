HW1_4a

.protect
.include '16mos.pm' TT
.include '7nm_TT.pm' TT
.include 'Buffer.sp'
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.include 'asap7sc7p5t_SIMPLE_RVT.sp'
.unprotect

**************************************************************
$Buffer
**  name  A(in)  Y(out) subckt_name **
Xbuffer_1 VA Vin1 Vdd Vss buffer 
Xbuffer_2 VB Vin2 Vdd Vss buffer

**  name  VSS  VDD   A(in) B(in)   Y(out) **
*XNAND2xp33 VSS VDD  Vin1  Vin2  Vo_1 NAND2xp33_ASAP7_75t_R        $smallest NAND2
XNOR2xp33  VSS VDD  Vin1  Vin2  Vo_1 NOR2xp33_ASAP7_75t_R         $smallest NOR2

**  name  A(in)  Y(out) subckt_name **
Xinverter1 GND VDD Vo_1 Vinv_out INVxp33_ASAP7_75t_R
Xinverter2 GND VDD Vo_1 Vinv_out INVxp33_ASAP7_75t_R
Xinverter3 GND VDD Vo_1 Vinv_out INVxp33_ASAP7_75t_R
Xinverter4 GND VDD Vo_1 Vinv_out INVxp33_ASAP7_75t_R
Cc1 Vo_1 gnd 10fF

**************************************************************
Vdd Vdd gnd 0.7V
Vss Vss gnd 0V
**(initial value, pulsed value, delay, rise time, fall time, pulse width, period)
* VA  VA  gnd PULSE ( 0V 0.7V 0.5n 0.05n 0.05n 0.5n 1n )
* VB  VB  gnd PULSE ( 0V 0.7V 1.2n 0.05n 0.05n 1n  2n )

VA VA GND PULSE(0v 0.7v 0.5ns 0ns 0ns 0.5ns 1ns)
VB VB gnd 0

**************************************************************
.op
.tran 1n 20n           $暫態響應， 語法：.TRAN 時間增量 停止時間

.meas tran tr *rising time
+ TRIG v(Vo_1) VAL='0.07' RISE=1            $when to start measuring the rising time
+ TARG v(Vo_1) VAL='0.63' RISE=1            $when to end measuring the rising time

.meas tran tf *falling time
+ TRIG v(Vo_1) VAL='0.63' FALL=1
+ TARG v(Vo_1) VAL='0.07' FALL=1

.meas tran tplh *prop delay low to high
+ TRIG v(VA)  VAL='0.35' FALL=1
+ TARG v(Vo_1) VAL='0.35' RISE=1

.meas tran tphl *prop delay high to low
+ TRIG v(VA)  VAL='0.35' RISE=1
+ TARG v(Vo_1) VAL='0.35' FALL=1

.meas propogation_delay
+ param='(tphl+tplh)/2'

.meas pwr avg Power

**************************************************************
.temp 25
.option post 
+ post				$output waveform to user
+ acout=0 runlvl=6		$increase simulation accuracy
+ captable			$list every node capacitance
  
.end



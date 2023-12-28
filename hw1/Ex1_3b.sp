TITLE hw3_b
*****************************
**     Library setting     **
*****************************
.protect
.include '16mos.pm' TT
.include '7nm_TT.pm' TT
.include 'Buffer.sp'
.unprotect

*****************************
**     Voltage Source      **
*****************************
.global VDD GND
Vvdd VDD GND 0.7v
Vgnd GND GND 0v

*****************************
**      Your Circuit       **
*****************************

.SUBCKT inverter1_mos in out 
mp out in vdd x  PMOS  W=16n L=16n m=7
mn out in gnd x  NMOS  W=16n L=16n m=5
.ends

Xbuf Vsw Vin Vdd gnd buffer
Xinv0 Vin Vout inverter1_mos
Cload Vout gnd 10fF
Xinv1 Vout Vinv_out inverter1_mos
Xinv2 Vout Vinv_out inverter1_mos
Xinv3 Vout Vinv_out inverter1_mos
Xinv4 Vout Vinv_out inverter1_mos

**(initial value, pulsed value, delay, rise time, fall time, pulse width, period)
*Vsw Vsw gnd PULSE ( 0V 0.7V 0n 0.01n 0.01n 0.5n 1n )                $1GHz
*Vsw Vsw gnd PULSE ( 0V 0.7V 0n 0.01n 0.01n 0.25n 0.5n )             $2GHz
Vsw Vsw gnd PULSE ( 0V 0.7V 0n 0.001n 0.001n 0.125n 0.25n )        $4GHz


*****************************
**      Measurement        **
*****************************
.op
.tran 0.1ns 20ns
.measure TRAN Static_pwr avg POWER from=0.0n to=20.0n
**************************************************************
.temp 25
.option post 
+ post				$output waveform to user
+ acout=0 runlvl=6		$increase simulation accuracy
+ captable			$list every node capacitance
  
.end
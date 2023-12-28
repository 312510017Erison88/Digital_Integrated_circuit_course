TITLE hw3_a
*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm'
.include 'Buffer.sp'
.unprotect

*****************************
**     Voltage Source      **
*****************************
.global VDD GND
Vvdd VDD GND 0.7v
Vgnd GND 0v 0v

*****************************
**      Your Circuit       **
*****************************

.SUBCKT inverter1_fin in out 
mp out in vdd x  pmos_rvt  m=6
mn out in gnd x  nmos_rvt  m=5
.ends

Xbuf Vsw Vin Vdd gnd buffer
Xinv0 Vin Vout inverter1_fin
Cload Vout gnd 10fF
Xinv1 Vout Vinv_out inverter1_fin
Xinv2 Vout Vinv_out inverter1_fin
Xinv3 Vout Vinv_out inverter1_fin
Xinv4 Vout Vinv_out inverter1_fin

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
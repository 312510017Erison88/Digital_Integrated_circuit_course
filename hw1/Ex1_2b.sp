HW1_2b

.protect
.include '16mos.pm' TT
* .include '7nm_TT.pm' TT

.unprotect

** name  D   G   S    X **
MP VoutM Vin Vdd Vdd PMOS W=16n L=16n m=7
MN VoutM Vin gnd gnd NMOS W=16n L=16n m=5

* MP VoutF Vin Vdd Vdd PMOS_lvt W=7n L=7n m=6
* MN VoutF Vin gnd gnd NMOS_lvt W=7n L=7n m=5

Vdd Vdd gnd 0.7V
Vin Vin gnd 

.op
.dc Vin 0 0.7 0.01 

.probe gainMOS=deriv('v(voutM)')
*.probe gainFIN=deriv('v(voutF)')

.tf V(VoutM) Vin           $to calculate the gain(output/input)，語法：.TF 輸出變數 輸入訊號源
*.tf V(VoutF) Vin

.temp 25
.option post 
+ post				$output waveform to user
+ acout=0 runlvl=6		$increase simulation accuracy
+ captable			$list every node capacitance
  
.end
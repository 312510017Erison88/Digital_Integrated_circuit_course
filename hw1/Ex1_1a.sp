.TITLE HW1_1b

*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm' TT
.unprotect

*****************************
**      Your Circuit       **
*****************************
**  D   G   S    X **

MP VDD Vin gnd Vdd pmos_lvt W=7n L=7n m=1
MN Vdd Vin gnd gnd nmos_lvt W=7n L=7n m=1

* .global Vdd Gnd
*n type
VVdd Vdd gnd 0.7V
*p type
*VVdd Vdd gnd -0.7V
Vgs Vin gnd
Vgnd gnd 0 0V

.op         $ set the DC operating point, output will have .lis file
*.dc Vgs 0 0.7 0.01  $ 掃描Vin由0V~0.7V，遞增直為0.01V(語法：.DC 變數 起始點 結束點 遞增值)
.dc Vgs -0.7 0.7 0.01
.probe I(MN)        
.probe I(MP)

*****************************
**    Simulator setting    **
*****************************
.Temp 25
.option post 
+ post				$output waveform to user
+ acout=0 runlvl=6		$increase simulation accuracy
+ captable			$list every node capacitance


.end




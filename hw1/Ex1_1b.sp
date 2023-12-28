.TITLE HW1_1a

*****************************
**     Library setting     **
*****************************
.protect
.include '16mos.pm' TT
.unprotect

*****************************
**      Your Circuit       **
*****************************
**  D   G   S    X **

MP Vdd Vin gnd Vdd PMOS W=16n L=16n m=1
MN Vdd Vin gnd gnd NMOS W=16n L=16n m=1

**name connect base voltage**

*.global Vdd gnd
*n type
Vdd Vdd gnd 0.7V
*p type
*Vdd Vdd gnd -0.7V

Vgs Vin gnd
Vgnd gnd 0 0V



.op         $ set the DC operating point, output will have .lis file
.tran 0.1ns 80ns
.dc Vgs 0 0.7 0.01  $ 掃描Vin由0V~0.7V，遞增直為0.01V(語法：.DC 變數 起始點 結束點 遞增值) output have .lis file
.probe I(MN)        $.PROBE是用來量輸出變數儲存到HSPICE的介面圖形資料檔中
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




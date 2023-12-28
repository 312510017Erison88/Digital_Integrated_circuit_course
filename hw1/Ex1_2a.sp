.TITLE HW1_2a

*****************************
**     Library setting     **
*****************************
.protect
.include '7nm_TT.pm' TT
.include 'asap7sc7p5t_INVBUF_RVT.sp'
.unprotect

*****************************
**      Your Circuit       **
*****************************


**  name  VSS  VDD   A(in)   Y(out) **
XINVxp33  VSS VDD Vin Voutxp33 INVxp33_ASAP7_75t_R      $ smallest_out
*XINVx1  VSS VDD Vin Voutx1  INVx1_ASAP7_75t_R
XINVx13 VSS VDD Vin Voutx13 INVx13_ASAP7_75t_R          $ Largest_out

**name connect base voltage**

*.global Vdd gnd
Vdd Vdd gnd 0.7V
Vin Vin gnd 0V
Vss Vss gnd 0V


.op         $ set the DC operating point, output will have .lis file
.dc Vin 0 0.7 0.01 sweep Vdd 0.4 0.7 0.1
*.probe I(MN)     
*.probe I(MP)
.tf V(Voutxp33) Vin
.tf V(Voutx13) Vin      $計算輸出電壓 (V(VOUT)) 比上輸入訊號 (VIN) 的增益

*****************************
**    Simulator setting    **
*****************************
.Temp 25
.option post 
+ post				$output waveform to user
+ acout=0 runlvl=6		$increase simulation accuracy
+ captable			$list every node capacitance


.end


.subckt inverter in out VDD GND
	Mp  out  in  VDD  x  pmos_rvt  m=1
	Mn  out  in  GND  x  nmos_rvt  m=1
.ends
.subckt buffer in out VDD GND
	X_INV1 in   in_b VDD GND inverter
	X_INV2 in_b out  VDD GND inverter
.ends
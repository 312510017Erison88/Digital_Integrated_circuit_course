`timescale 1ns/1ps
`ifdef RTL
`include "Convolution.v"
`elsif GATE
`include "Convolution_SYN.v"
`endif

`include "PATTERN.v"


module TESTBED;
   //input
	wire clk;
	wire rst_n;
	wire in_valid;
	wire weight_valid;
	wire [3:0]In_IFM_1;
        wire [3:0]In_IFM_2;
	wire [3:0]In_IFM_3;
	wire [3:0]In_IFM_4;
	wire [3:0]In_IFM_5;
	wire [3:0]In_IFM_6;
	wire [3:0]In_IFM_7;
	wire [3:0]In_IFM_8;
	wire [3:0]In_IFM_9;
	wire [3:0]In_IFM_10;
	wire [3:0]In_IFM_11;
	wire [3:0]In_IFM_12;
	wire [3:0]In_IFM_13;
	wire [3:0]In_IFM_14;
	wire [3:0]In_IFM_15;
	wire [3:0]In_IFM_16;
	wire [3:0]In_IFM_17;
	wire [3:0]In_IFM_18;
	wire [3:0]In_IFM_19;
	wire [3:0]In_IFM_20;
	wire [3:0]In_IFM_21;
	wire [3:0]In_IFM_22;
	wire [3:0]In_IFM_23;
	wire [3:0]In_IFM_24;
	wire [3:0]In_IFM_25;
	wire [3:0]In_IFM_26;
	wire [3:0]In_IFM_27;
	wire [3:0]In_IFM_28;
	wire [3:0]In_IFM_29;
	wire [3:0]In_IFM_30;
	wire [3:0]In_IFM_31;
	wire [3:0]In_IFM_32;
	wire [3:0]In_Weight_1;
  	wire [3:0]In_Weight_2;
	wire [3:0]In_Weight_3;
	wire [3:0]In_Weight_4;
	wire [3:0]In_Weight_5;
	wire [3:0]In_Weight_6;
	wire [3:0]In_Weight_7;
	wire [3:0]In_Weight_8;
	wire [3:0]In_Weight_9;
	wire [3:0]In_Weight_10;
	wire [3:0]In_Weight_11;
	wire [3:0]In_Weight_12;
	wire [3:0]In_Weight_13;
	wire [3:0]In_Weight_14;
	wire [3:0]In_Weight_15;
	wire [3:0]In_Weight_16;
	wire [3:0]In_Weight_17;
	wire [3:0]In_Weight_18;
	wire [3:0]In_Weight_19;
	wire [3:0]In_Weight_20;
	wire [3:0]In_Weight_21;
	wire [3:0]In_Weight_22;
	wire [3:0]In_Weight_23;
	wire [3:0]In_Weight_24;
	wire [3:0]In_Weight_25;
	wire [3:0]In_Weight_26;
	wire [3:0]In_Weight_27;
	wire [3:0]In_Weight_28;
	wire [3:0]In_Weight_29;
	wire [3:0]In_Weight_30;
	wire [3:0]In_Weight_31;
	wire [3:0]In_Weight_32;
	
	//output
	wire out_valid;
	wire [12:0] Out_OFM;

	
	
initial begin
	`ifdef RTL
		$fsdbDumpfile("Convolution.fsdb");
		$fsdbDumpvars();
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Convolution_SYN.fsdb");
		//`endif
		$sdf_annotate("Convolution_SYN.sdf",u_Convolution);   	
		$fsdbDumpvars(0,"+mda");
		$fsdbDumpvars();
	`endif
end



Convolution	u_Convolution	(
		.clk(clk),
		.rst_n(rst_n),	
		.in_valid(in_valid),
		.weight_valid(weight_valid),
		.In_IFM_1(In_IFM_1),
 		.In_IFM_2(In_IFM_2),
		.In_IFM_3(In_IFM_3),
		.In_IFM_4(In_IFM_4),
		.In_IFM_5(In_IFM_5),
		.In_IFM_6(In_IFM_6),
		.In_IFM_7(In_IFM_7),
		.In_IFM_8(In_IFM_8),
		.In_IFM_9(In_IFM_9),
		.In_IFM_10(In_IFM_10),
		.In_IFM_11(In_IFM_11),
		.In_IFM_12(In_IFM_12),
		.In_IFM_13(In_IFM_13),
		.In_IFM_14(In_IFM_14),
		.In_IFM_15(In_IFM_15),
		.In_IFM_16(In_IFM_16),
		.In_IFM_17(In_IFM_17),
		.In_IFM_18(In_IFM_18),
		.In_IFM_19(In_IFM_19),
		.In_IFM_20(In_IFM_20),
		.In_IFM_21(In_IFM_21),
		.In_IFM_22(In_IFM_22),
		.In_IFM_23(In_IFM_23),
		.In_IFM_24(In_IFM_24),
		.In_IFM_25(In_IFM_25),
		.In_IFM_26(In_IFM_26),
		.In_IFM_27(In_IFM_27),
		.In_IFM_28(In_IFM_28),
		.In_IFM_29(In_IFM_29),
		.In_IFM_30(In_IFM_30),
		.In_IFM_31(In_IFM_31),
		.In_IFM_32(In_IFM_32),
		.In_Weight_1(In_Weight_1),
		.In_Weight_2(In_Weight_2),
		.In_Weight_3(In_Weight_3),
		.In_Weight_4(In_Weight_4),
		.In_Weight_5(In_Weight_5),
		.In_Weight_6(In_Weight_6),
		.In_Weight_7(In_Weight_7),
		.In_Weight_8(In_Weight_8),
		.In_Weight_9(In_Weight_9),
		.In_Weight_10(In_Weight_10),
		.In_Weight_11(In_Weight_11),
		.In_Weight_12(In_Weight_12),
		.In_Weight_13(In_Weight_13),
		.In_Weight_14(In_Weight_14),
		.In_Weight_15(In_Weight_15),
		.In_Weight_16(In_Weight_16),
		.In_Weight_17(In_Weight_17),
		.In_Weight_18(In_Weight_18),
		.In_Weight_19(In_Weight_19),
		.In_Weight_20(In_Weight_20),
		.In_Weight_21(In_Weight_21),
		.In_Weight_22(In_Weight_22),
		.In_Weight_23(In_Weight_23),
		.In_Weight_24(In_Weight_24),
		.In_Weight_25(In_Weight_25),
		.In_Weight_26(In_Weight_26),
		.In_Weight_27(In_Weight_27),
		.In_Weight_28(In_Weight_28),
		.In_Weight_29(In_Weight_29),
		.In_Weight_30(In_Weight_30),
		.In_Weight_31(In_Weight_31),
		.In_Weight_32(In_Weight_32),
		.out_valid(out_valid), 
		.Out_OFM(Out_OFM)
		);

PATTERN	u_PATTERN(
		.clk(clk),
		.rst_n(rst_n),	
		.in_valid(in_valid),
		.weight_valid(weight_valid),
		.In_IFM_1(In_IFM_1),
		.In_IFM_2(In_IFM_2),
		.In_IFM_3(In_IFM_3),
		.In_IFM_4(In_IFM_4),
		.In_IFM_5(In_IFM_5),
		.In_IFM_6(In_IFM_6),
		.In_IFM_7(In_IFM_7),
		.In_IFM_8(In_IFM_8),
		.In_IFM_9(In_IFM_9),
		.In_IFM_10(In_IFM_10),
		.In_IFM_11(In_IFM_11),
		.In_IFM_12(In_IFM_12),
		.In_IFM_13(In_IFM_13),
		.In_IFM_14(In_IFM_14),
		.In_IFM_15(In_IFM_15),
		.In_IFM_16(In_IFM_16),
		.In_IFM_17(In_IFM_17),
		.In_IFM_18(In_IFM_18),
		.In_IFM_19(In_IFM_19),
		.In_IFM_20(In_IFM_20),
		.In_IFM_21(In_IFM_21),
		.In_IFM_22(In_IFM_22),
		.In_IFM_23(In_IFM_23),
		.In_IFM_24(In_IFM_24),
		.In_IFM_25(In_IFM_25),
		.In_IFM_26(In_IFM_26),
		.In_IFM_27(In_IFM_27),
		.In_IFM_28(In_IFM_28),
		.In_IFM_29(In_IFM_29),
		.In_IFM_30(In_IFM_30),
		.In_IFM_31(In_IFM_31),
		.In_IFM_32(In_IFM_32),
		.In_Weight_1(In_Weight_1),
		.In_Weight_2(In_Weight_2),
		.In_Weight_3(In_Weight_3),
		.In_Weight_4(In_Weight_4),
		.In_Weight_5(In_Weight_5),
		.In_Weight_6(In_Weight_6),
		.In_Weight_7(In_Weight_7),
		.In_Weight_8(In_Weight_8),
		.In_Weight_9(In_Weight_9),
		.In_Weight_10(In_Weight_10),
		.In_Weight_11(In_Weight_11),
		.In_Weight_12(In_Weight_12),
		.In_Weight_13(In_Weight_13),
		.In_Weight_14(In_Weight_14),
		.In_Weight_15(In_Weight_15),
		.In_Weight_16(In_Weight_16),
		.In_Weight_17(In_Weight_17),
		.In_Weight_18(In_Weight_18),
		.In_Weight_19(In_Weight_19),
		.In_Weight_20(In_Weight_20),
		.In_Weight_21(In_Weight_21),
		.In_Weight_22(In_Weight_22),
		.In_Weight_23(In_Weight_23),
		.In_Weight_24(In_Weight_24),
		.In_Weight_25(In_Weight_25),
		.In_Weight_26(In_Weight_26),
		.In_Weight_27(In_Weight_27),
		.In_Weight_28(In_Weight_28),
		.In_Weight_29(In_Weight_29),
		.In_Weight_30(In_Weight_30),
		.In_Weight_31(In_Weight_31),
		.In_Weight_32(In_Weight_32),
		.out_valid(out_valid), 
		.Out_OFM(Out_OFM)
		);
		
endmodule
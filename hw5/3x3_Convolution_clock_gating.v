// synopsys translate_off
`include "asap7sc7p5t_SEQ_RVT_TT_08302018.v"
// synopsys translate_on

module Convolution_clock_gating(
	//input
    clk,
    rst_n,
	in_valid,
	weight_valid,
	In_IFM_1,
	In_IFM_2,
	In_IFM_3,
	In_IFM_4,
    In_IFM_5,
	In_IFM_6,
	In_IFM_7,
	In_IFM_8,
	In_IFM_9,
    In_Weight_1,
    In_Weight_2,
    In_Weight_3,
	In_Weight_4,
    In_Weight_5,
    In_Weight_6,
    In_Weight_7,
    In_Weight_8,
    In_Weight_9,
	//output
    out_valid, 
	Out_OFM	

);

input clk, rst_n, in_valid, weight_valid;
input [7:0]In_IFM_1;
input [7:0]In_IFM_2;
input [7:0]In_IFM_3;
input [7:0]In_IFM_4;
input [7:0]In_IFM_5;
input [7:0]In_IFM_6;
input [7:0]In_IFM_7;
input [7:0]In_IFM_8;
input [7:0]In_IFM_9;	

input [7:0]In_Weight_1;
input [7:0]In_Weight_2;
input [7:0]In_Weight_3;
input [7:0]In_Weight_4;
input [7:0]In_Weight_5;
input [7:0]In_Weight_6;
input [7:0]In_Weight_7;
input [7:0]In_Weight_8;
input [7:0]In_Weight_9;

output reg out_valid;
output reg [20:0] Out_OFM;
reg[20:0] Out_OFM_n;

//////////////////////////////////////////
reg [7:0] IFM_Buffer[0:8];
reg [7:0] Weight_Buffer[0:8];

reg [7:0] IFM_DFF[0:8];
reg [7:0] Weight_DFF[0:8];

reg [15:0] mul[0:8];


////////////////////
reg is_zero[0:8];
reg current_state;
wire next_state;

wire clk_gate_1;
wire clk_gate_2;
wire clk_gate_3;
wire clk_gate_4;
wire clk_gate_5;

wire Enable_1;
wire Enable_2;
wire Enable_3;
wire Enable_4;

reg Enable_n1 ,Enable_n2 ,Enable_n3, Enable_n4;

integer i;

// state condition
assign next_state = (in_valid) ? 1:0;
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		current_state <= 0;
	else
		current_state <= next_state;
end

// (Weight_DFF[i]==0 || IFM_DFF[i]) is zero
always@(*)begin
	for(i=0; i<9; i=i+1) begin
		if(Weight_DFF[i]==0 || IFM_DFF[i]==0)
			is_zero[i] = 0;
		else
			is_zero[i] = 1;
	end
end

// Enable signals for clock gating
assign Enable_1 = (is_zero[0]|is_zero[1]|is_zero[2]|is_zero[3]|is_zero[4]|is_zero[5]|is_zero[6]|is_zero[7]|is_zero[8])? 1:0;
//assign Enable_2 = (is_zero[4]|is_zero[5]|is_zero[6]|is_zero[7]|is_zero[8])? 1:0;


// Clock Gating cells
ICGx3_ASAP7_75t_R GATED_CG_U1(.CLK(clk), .ENA(0), .SE(Enable_1), .GCLK(clk_gate_1));
// ICGx3_ASAP7_75t_R GATED_CG_U2(.CLK(clk), .ENA(0), .SE(Enable_2), .GCLK(clk_gate_2));
ICGx3_ASAP7_75t_R GATED_CG_U5(.CLK(clk), .ENA(0), .SE(weight_valid), .GCLK(clk_gate_5));

// Receive input 
always@(*) begin
	if(!in_valid) begin
		for(i=0; i<9; i=i+1)
			IFM_DFF[i] = 0;
	end
	else begin
		IFM_DFF[0] = In_IFM_1;
		IFM_DFF[1] = In_IFM_2;
		IFM_DFF[2] = In_IFM_3;
		IFM_DFF[3] = In_IFM_4;
		IFM_DFF[4] = In_IFM_5;
		IFM_DFF[5] = In_IFM_6;
		IFM_DFF[6] = In_IFM_7;
		IFM_DFF[7] = In_IFM_8;
		IFM_DFF[8] = In_IFM_9;
	end
end

// Receive Weight 
always@(*) begin
	if(!weight_valid) begin
		for(i=0; i<9; i=i+1)
		Weight_DFF[i] = Weight_Buffer[i];
	end
	else begin
		Weight_DFF[0] = In_Weight_1;
		Weight_DFF[1] = In_Weight_2;
		Weight_DFF[2] = In_Weight_3;
		Weight_DFF[3] = In_Weight_4;
		Weight_DFF[4] = In_Weight_5;
		Weight_DFF[5] = In_Weight_6;
		Weight_DFF[6] = In_Weight_7;
		Weight_DFF[7] = In_Weight_8;
		Weight_DFF[8] = In_Weight_9;
	end
end

// DFF Weight_Buffer
always@(posedge clk_gate_5 or negedge rst_n) begin
	if(!rst_n) begin
		for (i=0;i<9;i=i+1) 
			Weight_Buffer[i] <= 0;
	end
	else if(weight_valid) begin
		for(i=0;i<9;i=i+1) begin
			Weight_Buffer[i] <= Weight_DFF[i];
		end
	end
	else begin
		for(i=0; i<9; i=i+1)
			Weight_Buffer[i] <= Weight_Buffer[i];
	end
end

// DFF IFM_Buffer
always@(posedge clk_gate_1 or negedge rst_n) begin
	if(!rst_n)begin
		for(i=0;i<9;i=i+1) begin
			IFM_Buffer[i] <= 0;
		end
	end
	else if(Enable_1)begin
		for(i=0;i<9;i=i+1) begin
			IFM_Buffer[i] <= IFM_DFF[i];
		end
	end
	else begin
		for(i=0;i<9;i=i+1) begin
			IFM_Buffer[i] <= IFM_Buffer[i];
		end
	end
end
// always@(posedge clk_gate_2 or negedge rst_n) begin
// 	if(!rst_n)begin
// 		for(i=4;i<9;i=i+1) begin
// 			IFM_Buffer[i] <= 0;
// 		end
// 	end
// 	else if(Enable_2)begin
// 		for(i=4;i<9;i=i+1) begin
// 			IFM_Buffer[i] <= IFM_DFF[i];
// 		end
// 	end
// 	else begin
// 		for(i=4;i<9;i=i+1) begin
// 			IFM_Buffer[i] <= IFM_Buffer[i];
// 		end
// 	end
// end

// always@(posedge clk_gate_3 or negedge rst_n) begin
// 	if(!rst_n)begin
// 		IFM_Buffer[4] <= 0;
// 		IFM_Buffer[5] <= 0;
// 	end
// 	else if(Enable_3)begin
// 		IFM_Buffer[4] <= IFM_DFF[4];
// 		IFM_Buffer[5] <= IFM_DFF[5];
// 	end
// 	else begin
// 		IFM_Buffer[4] <= IFM_Buffer[4];
// 		IFM_Buffer[5] <= IFM_Buffer[5];
// 	end
// end
// always@(posedge clk_gate_4 or negedge rst_n) begin
// 	if(!rst_n)begin
// 		IFM_Buffer[6] <= 0;
// 		IFM_Buffer[7] <= 0;
// 		IFM_Buffer[8] <= 0;
// 	end
// 	else if(Enable_4)begin
// 		IFM_Buffer[6] <= IFM_DFF[6];
// 		IFM_Buffer[7] <= IFM_DFF[7];
// 		IFM_Buffer[8] <= IFM_DFF[8];
// 	end
// 	else begin
// 		for(i=6;i<9;i=i+1)
// 			IFM_Buffer[i] <= IFM_Buffer[i];
// 	end
// end


////////////////////////////////////////////////////////////////
always@(posedge clk)begin
    Enable_n1 <= Enable_1;
	// Enable_n2 <= Enable_2;
	// Enable_n3 <= Enable_3;
	// Enable_n4 <= Enable_4;
end

//////////////////////////////////////////////////////////
// Multiplers combinational logic
always@(*) begin
	for(i=0; i<9; i=i+1) begin
		mul[i] = Weight_Buffer[i] * IFM_Buffer[i];
	end
end

always@(*)begin
	case({Enable_n1})
		1'b0: Out_OFM_n = 0;
		1'b1: Out_OFM_n = mul[0] + mul[1] + mul[2] + mul[3] + mul[4] + mul[5] + mul[6] + mul[7] + mul[8];
		// 2'b00: Out_OFM_n = 0;
		// 2'b10: Out_OFM_n = mul[0] + mul[1] + mul[2] + mul[3];
		// 2'b01: Out_OFM_n = mul[4] + mul[5] + mul[6] + mul[7] + mul[8];
		// 2'b11: Out_OFM_n = mul[0] + mul[1] + mul[2] + mul[3] + mul[4] + mul[5] + mul[6] + mul[7] + mul[8];

		default: Out_OFM_n = 0;
	endcase
end

// output
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		Out_OFM <= 0;
		out_valid <= 0;
	end
	else if(current_state)begin
		Out_OFM <= Out_OFM_n;
		out_valid <= 1;
	end
	else begin
		Out_OFM <= 0;
		out_valid <= 0;		
	end
end

endmodule

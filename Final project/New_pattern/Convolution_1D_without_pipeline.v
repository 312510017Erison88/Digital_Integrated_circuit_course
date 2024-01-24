module Convolution(
	//Input Port
	clk,
	rst_n,
	in_valid,
	In_IFM_1, In_IFM_2, In_IFM_3, In_IFM_4, In_IFM_5, In_IFM_6, In_IFM_7, In_IFM_8, In_IFM_9,
	In_IFM_10, In_IFM_11, In_IFM_12, In_IFM_13, In_IFM_14, In_IFM_15, In_IFM_16, In_IFM_17, In_IFM_18, In_IFM_19,
	In_IFM_20, In_IFM_21, In_IFM_22, In_IFM_23, In_IFM_24, In_IFM_25, In_IFM_26, In_IFM_27, In_IFM_28, In_IFM_29,
	In_IFM_30, In_IFM_31, In_IFM_32,	
	//Output Port
	out_valid, 
	Out_OFM
);

input clk, rst_n, in_valid;
input [3:0] In_IFM_1, In_IFM_2, In_IFM_3, In_IFM_4, In_IFM_5, In_IFM_6, In_IFM_7, In_IFM_8, In_IFM_9;
input [3:0] In_IFM_10, In_IFM_11, In_IFM_12, In_IFM_13, In_IFM_14, In_IFM_15, In_IFM_16, In_IFM_17, In_IFM_18, In_IFM_19;
input [3:0] In_IFM_20, In_IFM_21, In_IFM_22, In_IFM_23, In_IFM_24, In_IFM_25, In_IFM_26, In_IFM_27, In_IFM_28, In_IFM_29;
input [3:0] In_IFM_30, In_IFM_31, In_IFM_32;

output reg out_valid;
output reg[12:0] Out_OFM;

reg [3:0]IFM_Buffer[0:31]; 
reg [3:0]Weight_Buffer[0:31];  

reg [2:0] count;
integer i,j;

always@(posedge clk ) begin
	if(in_valid) begin
		IFM_Buffer[0]  <= In_IFM_1;
		IFM_Buffer[1]  <= In_IFM_2;
		IFM_Buffer[2]  <= In_IFM_3;
		IFM_Buffer[3]  <= In_IFM_4;
		IFM_Buffer[4]  <= In_IFM_5;
		IFM_Buffer[5]  <= In_IFM_6;
		IFM_Buffer[6]  <= In_IFM_7;
		IFM_Buffer[7]  <= In_IFM_8;
		IFM_Buffer[8]  <= In_IFM_9;
		IFM_Buffer[9]  <= In_IFM_10;
		IFM_Buffer[10]  <= In_IFM_11;
		IFM_Buffer[11]  <= In_IFM_12;
		IFM_Buffer[12]  <= In_IFM_13;
		IFM_Buffer[13]  <= In_IFM_14;
		IFM_Buffer[14]  <= In_IFM_15;
		IFM_Buffer[15]  <= In_IFM_16;
		IFM_Buffer[16]  <= In_IFM_17;
		IFM_Buffer[17]  <= In_IFM_18;
		IFM_Buffer[18]  <= In_IFM_19;
		IFM_Buffer[19]  <= In_IFM_20;
		IFM_Buffer[20]  <= In_IFM_21;
		IFM_Buffer[21]  <= In_IFM_22;
		IFM_Buffer[22]  <= In_IFM_23;
		IFM_Buffer[23]  <= In_IFM_24;
		IFM_Buffer[24]  <= In_IFM_25;
		IFM_Buffer[25]  <= In_IFM_26;
		IFM_Buffer[26]  <= In_IFM_27;
		IFM_Buffer[27]  <= In_IFM_28;
		IFM_Buffer[28]  <= In_IFM_29;
		IFM_Buffer[29]  <= In_IFM_30;
		IFM_Buffer[30]  <= In_IFM_31;
		IFM_Buffer[31]  <= In_IFM_32;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		Weight_Buffer[0]  <= 4'd6;
		Weight_Buffer[1]  <= 4'd14;
		Weight_Buffer[2]  <= 4'd13;
		Weight_Buffer[3]  <= 4'd10;
		Weight_Buffer[4]  <= 4'd10;
		Weight_Buffer[5]  <= 4'd14;
		Weight_Buffer[6]  <= 4'd3;
		Weight_Buffer[7]  <= 4'd4;
		Weight_Buffer[8]  <= 4'd0;
		Weight_Buffer[9]  <= 4'd6;
		Weight_Buffer[10]  <= 4'd7;
		Weight_Buffer[11]  <= 4'd9;
		Weight_Buffer[12]  <= 4'd11;
		Weight_Buffer[13]  <= 4'd12;
		Weight_Buffer[14]  <= 4'd6;
		Weight_Buffer[15]  <= 4'd3;
		Weight_Buffer[16]  <= 4'd2;
		Weight_Buffer[17]  <= 4'd1;
		Weight_Buffer[18]  <= 4'd5;
		Weight_Buffer[19]  <= 4'd8;
		Weight_Buffer[20]  <= 4'd7;
		Weight_Buffer[21]  <= 4'd13;
		Weight_Buffer[22]  <= 4'd1;
		Weight_Buffer[23]  <= 4'd8;
		Weight_Buffer[24]  <= 4'd7;
		Weight_Buffer[25]  <= 4'd12;
		Weight_Buffer[26]  <= 4'd13;
		Weight_Buffer[27]  <= 4'd10;
		Weight_Buffer[28]  <= 4'd10;
		Weight_Buffer[29]  <= 4'd9;
		Weight_Buffer[30]  <= 4'd7;
		Weight_Buffer[31]  <= 4'd7;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		count <= 0;
	else if(in_valid)
		count <= 1;
	else
		count <= 0;
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		out_valid <= 0;
	else if(count)
		out_valid <= 1;
	else
		out_valid <= 0;
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		Out_OFM <= 0;
	else if(count) begin
		Out_OFM <=	IFM_Buffer[0]*Weight_Buffer[0]
				+IFM_Buffer[1]*Weight_Buffer[1]
				+IFM_Buffer[2]*Weight_Buffer[2]
				+IFM_Buffer[3]*Weight_Buffer[3]
				+IFM_Buffer[4]*Weight_Buffer[4]
				+IFM_Buffer[5]*Weight_Buffer[5]
				+IFM_Buffer[6]*Weight_Buffer[6]
				+IFM_Buffer[7]*Weight_Buffer[7]
				+IFM_Buffer[8]*Weight_Buffer[8]
				+IFM_Buffer[9]*Weight_Buffer[9]
				+IFM_Buffer[10]*Weight_Buffer[10]
				+IFM_Buffer[11]*Weight_Buffer[11]
				+IFM_Buffer[12]*Weight_Buffer[12]
				+IFM_Buffer[13]*Weight_Buffer[13]
				+IFM_Buffer[14]*Weight_Buffer[14]
				+IFM_Buffer[15]*Weight_Buffer[15]
				+IFM_Buffer[16]*Weight_Buffer[16]
				+IFM_Buffer[17]*Weight_Buffer[17]
				+IFM_Buffer[18]*Weight_Buffer[18]
				+IFM_Buffer[19]*Weight_Buffer[19]
				+IFM_Buffer[20]*Weight_Buffer[20]
				+IFM_Buffer[21]*Weight_Buffer[21]
				+IFM_Buffer[22]*Weight_Buffer[22]
				+IFM_Buffer[23]*Weight_Buffer[23]
				+IFM_Buffer[24]*Weight_Buffer[24]
				+IFM_Buffer[25]*Weight_Buffer[25]
				+IFM_Buffer[26]*Weight_Buffer[26]
				+IFM_Buffer[27]*Weight_Buffer[27]
				+IFM_Buffer[28]*Weight_Buffer[28]
				+IFM_Buffer[29]*Weight_Buffer[29]
				+IFM_Buffer[30]*Weight_Buffer[30]
				+IFM_Buffer[31]*Weight_Buffer[31];
	end
	else
		Out_OFM <= 0;
end

endmodule

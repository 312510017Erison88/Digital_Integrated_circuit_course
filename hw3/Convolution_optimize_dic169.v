module Convolution_optimize_dic169(
	//input
    clk,
    rst_n,
	in_valid,
	weight_valid,
	In_IFM_1,
    In_Weight_1,

	//output
    out_valid, 
	Out_OFM	
);

input clk, rst_n, in_valid, weight_valid;
input [15:0]In_IFM_1;
input [15:0]In_Weight_1;

//////////////The output port shoud be registers///////////////////////
output reg out_valid;
output reg [35:0] Out_OFM;

// 2 Buffer
//You have to use these buffers for the 3-1 & 3-2 /////// 
reg [15:0]IFM_Buffer[0:27];   //  Use this buffer to store IFM   

reg [15:0]Weight_Buffer[0:8];  //  Use this buffer to store Weight

// reg [15:0] temp[0:8];
reg [31:0] temp[0:3];
reg [15:0] temp_1;
reg [5:0] count;	// first count datain, then count for EXE
reg [5:0] count_out;
//reg [31:0] Multiple[0:8];
reg[63:0] Multiple[0:30];
reg[31:0] Multiple_1;
reg [33:0] add[0:3];

///////////////////////////////////////////////
// read data to IMF_Buffer
integer i;
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for(i=0 ; i<28 ; i=i+1) begin
			IFM_Buffer[i] <= 0;
		end
	end
	else if(in_valid) begin
		IFM_Buffer[count%27] <= In_IFM_1;
	end
end

// read data to Weight_Buffer
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		for(i=0; i<9; i=i+1) begin
			Weight_Buffer[i] <= 0;
		end
	end
	else if (weight_valid) begin
		Weight_Buffer[count] <= In_Weight_1;
	end
end

///////////////////////////////////////////////////////////////////////////

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		count <= 0;
	else if(in_valid | out_valid)
		count <= count + 1;
	else
		count <= 0;
end

// define out_valid operation
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		out_valid <= 0;
	else if(count_out<=34 && count_out>=3)		// 34-2=32
		out_valid <= 1;
	else 
		out_valid <= 0;
end 

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		count_out <= 0;
		else if(count_out == 4 | count_out == 11 | count_out==18 | count_out==25)
			count_out <= count_out + 3;
		else if(count >= 25 && count <= 52)		// 52-24 = 28
			count_out <= count_out + 1;
		else
			count_out <= 0;
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		Out_OFM <= 0; 
	end
	else if(count >= 25 && count <= 51) begin	
		// temp[0] <= IFM_Buffer[count_out%27];
		// temp[1] <= IFM_Buffer[(count_out+1)%27];
		// temp[2] <= IFM_Buffer[(count_out+2)%27];
		// temp[3] <= IFM_Buffer[(count_out+7)%27];
		// temp[4] <= IFM_Buffer[(count_out+8)%27];
		// temp[5] <= IFM_Buffer[(count_out+9)%27];
		// temp[6] <= IFM_Buffer[(count_out+14)%27];
		// temp[7] <= IFM_Buffer[(count_out+15)%27];
		// temp[8] <= IFM_Buffer[(count_out+16)%27];

		temp[0][15:0] <= IFM_Buffer[count_out%27];
		temp[0][31:16] <= IFM_Buffer[(count_out+1)%27];
		temp[1][15:0] <= IFM_Buffer[(count_out+2)%27];
		temp[1][31:16] <= IFM_Buffer[(count_out+7)%27];
		temp[2][15:0] <= IFM_Buffer[(count_out+8)%27];
		temp[2][31:16] <= IFM_Buffer[(count_out+9)%27];
		temp[3][15:0] <= IFM_Buffer[(count_out+14)%27];
		temp[3][31:16] <= IFM_Buffer[(count_out+15)%27];
		temp_1 <= IFM_Buffer[(count_out+16)%27];

		// for(i=0; i<9; i=i+1) begin
		// 	Multiple[i] <= Weight_Buffer[i] * temp[i];
		// end
		Multiple[0][31:0] <= Weight_Buffer[0] * temp[0][15:0];
		Multiple[0][63:32] <= Weight_Buffer[1] * temp[0][31:16];
		Multiple[1][31:0] <= Weight_Buffer[2] * temp[1][15:0];
		Multiple[1][63:32] <= Weight_Buffer[3] * temp[1][31:16];
		Multiple[2][31:0] <= Weight_Buffer[4] * temp[2][15:0];
		Multiple[2][63:32] <= Weight_Buffer[5] * temp[2][31:16];
		Multiple[3][31:0] <= Weight_Buffer[6] * temp[3][15:0];
		Multiple[3][63:32] <= Weight_Buffer[7] * temp[3][31:16];
		Multiple_1 <= Weight_Buffer[8] * temp_1;
		
		// add[0] <= Multiple[0] + Multiple[1] + Multiple[2];
		// add[1] <= Multiple[3] + Multiple[4];
		// add[2] <= Multiple[6] + Multiple[5];
		// add[3] <= Multiple[7] + Multiple[8];

		add[0] <= Multiple[0][31:0] + Multiple[0][63:32] + Multiple[1][31:0];
		add[1] <= Multiple[1][63:32]+ Multiple[2][31:0];
		add[2] <= Multiple[2][63:32] + Multiple[3][31:0];
		add[3] <= Multiple[3][63:32] + Multiple_1;

		if(count_out < 3)
			Out_OFM <= 0;
		else
			Out_OFM <= add[0] + add[1] + add[2] + add[3];
	end  
	else
		Out_OFM <= 0;
end

endmodule
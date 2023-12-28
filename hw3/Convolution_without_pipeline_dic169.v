module Convolution_without_pipeline_dic169(
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
reg [5:0]in[0:8];

//////////////The output port shoud be registers///////////////////////
output reg out_valid;
output reg [35:0] Out_OFM;

// 2 Buffer
//You have to use these buffers for the 3-1 & 3-2 /////// 
reg [15:0]IFM_Buffer[0:48];   //  Use this buffer to store IFM
reg [15:0]Weight_Buffer[0:8];  //  Use this buffer to store Weight

/////////////You need use Registers to receive inputs//////////////////////
reg [2:0] state_cs, state_ns; //current state , next state
parameter IDLE = 2'd0;
parameter IN_DATA = 2'd1;
parameter EXE = 2'd2;

reg [5:0] count_in;
//reg [4:0] count_out;

// sequential logic
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		state_cs <= IDLE;
	else
		state_cs <= state_ns;
end

// combinational logic、Finite state machine
always@(*) begin
	case(state_cs)
		IDLE:
		begin
			if(in_valid)
				state_ns = IN_DATA;
			else
				state_ns = IDLE;
		end

		IN_DATA:
		begin
			if(in_valid)
				state_ns = IN_DATA;
			else
				state_ns = EXE;
		end
		
		EXE:
		begin
			if(count_in == 24)
				state_ns = IDLE;
			else
				state_ns = EXE;
		end
		default:
			state_ns = IDLE;
	endcase
end

// declare count_in operation
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		count_in <= 0;
	end
	else if(in_valid) begin
		count_in <= count_in + 1;
	end
	else if(state_cs == EXE) begin
		count_in <= count_in + 1;
	end
	else if(!in_valid) begin
		count_in <= 0;
	end
end

/////////////////////////////////////////////////assistance code
// read data to IMF_Buffer
integer i;
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for (i=0 ; i<49 ; i=i+1) begin
			IFM_Buffer[i] <= 0;
		end
	end
	else if(in_valid) begin
		IFM_Buffer[count_in] <= In_IFM_1;
	end
end

// read data to Weight_Buffer
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		for (i=0; i<9; i=i+1) begin
			Weight_Buffer[i] <= 0;
		end
	end
	else if (weight_valid) begin
		Weight_Buffer[count_in] <= In_Weight_1;
	end
end

/*
integer i;
integer j;
integer count_weight=0;
integer count_IMF=0;
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for (i=0;i<9;i=i+1) 
			Weight_Buffer[i] <= 0;
	end
	
	else if(weight_valid) begin
		for (count_weight=0; count_weight<9; count_weight=count_weight+1)
			Weight_Buffer[count_weight] <= In_Weight_1;
			$display("Weight_Buffer[%h] = %4d ", count_weight, Weight_Buffer[count_weight]);
	end
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
        for (j=0;j<49;j=j+1)
		    IFM_Buffer[j]  <= 0;
        
	end
	else if(in_valid) begin
		for (count_IMF=0; count_IMF<49; count_IMF=count_IMF+1)
			IFM_Buffer[count_IMF]  <= In_IFM_1;
			$display("IFM_Buffer[%h] = %4d", count_IMF, IFM_Buffer[count_IMF]);
	end
end
*/
/*
// define count_out operation
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		count_out <= 0;
	else if(state_cs == EXE) begin
		count_out <= count_out + 1;
	end
	else
		count_out <= 0;
end
*/

// define out_valid operation
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		out_valid <= 0;
	else if(state_cs == EXE)
		out_valid <= 1;
	else
		out_valid <= 0;
end


// declare Out_OFM operation
always @(posedge clk or negedge rst_n) begin
	// initailize the in[] registers
	if(!rst_n) begin
		for(i=0; i<9; i=i+1) begin
			in[i] <= 0;
		end		
	end
	else if(!in_valid && count_in == 49) begin
		in[0] <= 0; 
		in[1] <= 1;
		in[2] <= 2; 
		in[3] <= 7; 
		in[4] <= 8;
		in[5] <= 9;
		in[6] <= 14; 
		in[7] <= 15;
		in[8] <= 16;
	end
	else if(state_cs == EXE) begin
		for (i = 0; i < 9; i = i + 1) begin
            in[i] <= (in[0] % 7 == 4) ? (in[i] + 3) : (in[i] + 1);
        end
	end
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		Out_OFM <= 0;
	else if(state_cs == EXE) begin
		Out_OFM <= IFM_Buffer[in[0]] * Weight_Buffer[0]
				 + IFM_Buffer[in[1]] * Weight_Buffer[1]
				 + IFM_Buffer[in[2]] * Weight_Buffer[2]
				 + IFM_Buffer[in[3]] * Weight_Buffer[3]
				 + IFM_Buffer[in[4]] * Weight_Buffer[4]
				 + IFM_Buffer[in[5]] * Weight_Buffer[5]
				 + IFM_Buffer[in[6]] * Weight_Buffer[6]
				 + IFM_Buffer[in[7]] * Weight_Buffer[7]
				 + IFM_Buffer[in[8]] * Weight_Buffer[8];
	end
	else
		Out_OFM <= 0;
end

/*
// declare Out_OFM operation
always@(posedge clk or negedge rst_n) begin
	if (!rst_n)begin
		Out_OFM <= 0;
	end
	else if (state_cs == EXE && count_in < 25) begin
		if (count_in < 5) begin
			Out_OFM <= IFM_Buffer[count_in+0] * Weight_Buffer[0]
					+ IFM_Buffer[count_in+1] * Weight_Buffer[1]
					+ IFM_Buffer[count_in+2] * Weight_Buffer[2]
					+ IFM_Buffer[count_in+7] * Weight_Buffer[3]
					+ IFM_Buffer[count_in+8] * Weight_Buffer[4]
					+ IFM_Buffer[count_in+9] * Weight_Buffer[5]
					+ IFM_Buffer[count_in+14] * Weight_Buffer[6]
					+ IFM_Buffer[count_in+15] * Weight_Buffer[7]
					+ IFM_Buffer[count_in+16] * Weight_Buffer[8];
		end 
		else if (count_in >= 5 && count_in < 10) begin
			Out_OFM <= IFM_Buffer[count_in+2] * Weight_Buffer[0]
					+ IFM_Buffer[count_in+3] * Weight_Buffer[1]
					+ IFM_Buffer[count_in+4] * Weight_Buffer[2]
					+ IFM_Buffer[count_in+9] * Weight_Buffer[3]
					+ IFM_Buffer[count_in+10] * Weight_Buffer[4]
					+ IFM_Buffer[count_in+11] * Weight_Buffer[5]
					+ IFM_Buffer[count_in+16] * Weight_Buffer[6]
					+ IFM_Buffer[count_in+17] * Weight_Buffer[7]
					+ IFM_Buffer[count_in+18] * Weight_Buffer[8];
		end 
		else if (count_in >= 10 && count_in < 15) begin
			Out_OFM <= IFM_Buffer[count_in+4] * Weight_Buffer[0]
					+ IFM_Buffer[count_in+5] * Weight_Buffer[1]
					+ IFM_Buffer[count_in+6] * Weight_Buffer[2]
					+ IFM_Buffer[count_in+11] * Weight_Buffer[3]
					+ IFM_Buffer[count_in+12] * Weight_Buffer[4]
					+ IFM_Buffer[count_in+13] * Weight_Buffer[5]
					+ IFM_Buffer[count_in+18] * Weight_Buffer[6]
					+ IFM_Buffer[count_in+19] * Weight_Buffer[7]
					+ IFM_Buffer[count_in+20] * Weight_Buffer[8];
		end 
		else if (count_in >= 15 && count_in < 20) begin
			Out_OFM <= IFM_Buffer[count_in+6] * Weight_Buffer[0]
					+ IFM_Buffer[count_in+7] * Weight_Buffer[1]
					+ IFM_Buffer[count_in+8] * Weight_Buffer[2]
					+ IFM_Buffer[count_in+13] * Weight_Buffer[3]
					+ IFM_Buffer[count_in+14] * Weight_Buffer[4]
					+ IFM_Buffer[count_in+15] * Weight_Buffer[5]
					+ IFM_Buffer[count_in+20] * Weight_Buffer[6]
					+ IFM_Buffer[count_in+21] * Weight_Buffer[7]
					+ IFM_Buffer[count_in+22] * Weight_Buffer[8];
		end 
		else if (count_in >= 20 && count_in < 25) begin
			Out_OFM <= IFM_Buffer[count_in+8] * Weight_Buffer[0]
					+ IFM_Buffer[count_in+9] * Weight_Buffer[1]
					+ IFM_Buffer[count_in+10] * Weight_Buffer[2]
					+ IFM_Buffer[count_in+15] * Weight_Buffer[3]
					+ IFM_Buffer[count_in+16] * Weight_Buffer[4]
					+ IFM_Buffer[count_in+17] * Weight_Buffer[5]
					+ IFM_Buffer[count_in+22] * Weight_Buffer[6]
					+ IFM_Buffer[count_in+23] * Weight_Buffer[7]
					+ IFM_Buffer[count_in+24] * Weight_Buffer[8];
		end
	end
	else
		Out_OFM <= 0;
end
*/

endmodule
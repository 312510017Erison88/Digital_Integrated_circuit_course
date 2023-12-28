module Convolution_with_pipeline_dic169(
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

reg [31:0] Multiple[0:8];
reg [34:0]P1[0:3];	//after Plus

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

reg [5:0] count_in;	// first count datain, then count for EXE

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
			state_ns = (in_valid) ? IN_DATA : IDLE;
		end

		IN_DATA:
		begin
			state_ns = (in_valid) ? IN_DATA : EXE;
		end
		
		EXE:
		begin
			if(count_in == 25)
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
		count_in <= 0;			// for recount the EXE
	end
end

///////////////////////////////////////////////
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

// define out_valid operation
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		out_valid <= 0;
	else if(state_cs == EXE && count_in > 1)
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
	if(!rst_n) begin
		for(i=0; i<9; i=i+1)
			Multiple[i] <= 0; 
	end
	else if(state_cs == EXE) begin	// when cnt=1 go in
		for(i=0; i<9; i=i+1)
			Multiple[i] <= IFM_Buffer[in[i]]*Weight_Buffer[i];
	end
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		for(i=0; i<4; i=i+1)
			P1[i] <= 0;
	end
	else if(state_cs == EXE && count_in > 0) begin	// when cnt=1 go in
		P1[0] <= Multiple[0]+ Multiple[1];
		P1[1] <= Multiple[2]+ Multiple[3];
		P1[2] <= Multiple[4]+ Multiple[5];
		P1[3] <= Multiple[6]+ Multiple[7]+ Multiple[8];
	end
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		Out_OFM <= 0;
	else if(state_cs == EXE && count_in > 1) begin		// when cnt=2 go in
		Out_OFM <= P1[0] + P1[1] + P1[2] + P1[3];
	end

	else
		Out_OFM <= 0;
end
endmodule
module Convolution(
    //input
    clk,
    rst_n,
    in_valid,
    //weight_valid,
    In_IFM_1,
    In_IFM_2,
    In_IFM_3,
    In_IFM_4,
    In_IFM_5,
    In_IFM_6,
    In_IFM_7,
    In_IFM_8,
    In_IFM_9,
    In_IFM_10,
    In_IFM_11,
    In_IFM_12,
    In_IFM_13,
    In_IFM_14,
    In_IFM_15,
    In_IFM_16,
    In_IFM_17,
    In_IFM_18,
    In_IFM_19,
    In_IFM_20,
    In_IFM_21,
    In_IFM_22,
    In_IFM_23,
    In_IFM_24,
    In_IFM_25,
    In_IFM_26,
    In_IFM_27,
    In_IFM_28,
    In_IFM_29,
    In_IFM_30,
    In_IFM_31,
    In_IFM_32,
    //output
    out_valid, 
    Out_OFM
);

input clk, rst_n, in_valid;
input [3:0]In_IFM_1;
input [3:0]In_IFM_2;
input [3:0]In_IFM_3;
input [3:0]In_IFM_4;
input [3:0]In_IFM_5;
input [3:0]In_IFM_6;
input [3:0]In_IFM_7;
input [3:0]In_IFM_8;
input [3:0]In_IFM_9;
input [3:0]In_IFM_10;
input [3:0]In_IFM_11;
input [3:0]In_IFM_12;
input [3:0]In_IFM_13;
input [3:0]In_IFM_14;
input [3:0]In_IFM_15;
input [3:0]In_IFM_16;
input [3:0]In_IFM_17;
input [3:0]In_IFM_18;
input [3:0]In_IFM_19;
input [3:0]In_IFM_20;
input [3:0]In_IFM_21;
input [3:0]In_IFM_22;
input [3:0]In_IFM_23;
input [3:0]In_IFM_24;
input [3:0]In_IFM_25;
input [3:0]In_IFM_26;
input [3:0]In_IFM_27;
input [3:0]In_IFM_28;
input [3:0]In_IFM_29;
input [3:0]In_IFM_30;
input [3:0]In_IFM_31;
input [3:0]In_IFM_32;


reg [7:0]MUL_Buffer[0:3][0:7];
reg [8:0]Adder_Buffer[0:3][0:4];

output reg out_valid;
output reg [12:0] Out_OFM;

reg [3:0] IFM[0:3][0:7];
reg [3:0] Weight[0:3][0:7];

// reg [7:0] count_out;
reg current_state;
reg current_state_2;
reg current_state_3;
wire next_state;

integer i,j;

// state condition
assign next_state = (in_valid) ? 1:0;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		current_state <= 0;
	else
		current_state <= next_state;
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		current_state_2 <= 0;
	else
		current_state_2 <= current_state;
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
		current_state_3 <= 0;
	else
		current_state_3 <= current_state_2;
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		Weight[0][0]  <= 4'd6;
		Weight[0][1]  <= 4'd14;
		Weight[0][2]  <= 4'd13;
		Weight[0][3]  <= 4'd10;
		Weight[0][4]  <= 4'd10;
		Weight[0][5]  <= 4'd14;
		Weight[0][6]  <= 4'd3;
		Weight[0][7]  <= 4'd4;
		Weight[1][0]  <= 4'd0;
		Weight[1][1]  <= 4'd6;
		Weight[1][2]  <= 4'd7;
		Weight[1][3]  <= 4'd9;
		Weight[1][4]  <= 4'd11;
		Weight[1][5]  <= 4'd12;
		Weight[1][6]  <= 4'd6;
		Weight[1][7]  <= 4'd3;
		Weight[2][0]  <= 4'd2;
		Weight[2][1]  <= 4'd1;
		Weight[2][2]  <= 4'd5;
		Weight[2][3]  <= 4'd8;
		Weight[2][4]  <= 4'd7;
		Weight[2][5]  <= 4'd13;
		Weight[2][6]  <= 4'd1;
		Weight[2][7]  <= 4'd8;
		Weight[3][0]  <= 4'd7;
		Weight[3][1]  <= 4'd12;
		Weight[3][2]  <= 4'd13;
		Weight[3][3]  <= 4'd10;
		Weight[3][4]  <= 4'd10;
		Weight[3][5]  <= 4'd9;
		Weight[3][6]  <= 4'd7;
		Weight[3][7]  <= 4'd7;
	end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<4; i=i+1) begin
          for(j=0; j<8; j=j+1) begin
            IFM[i][j] <= 0;
          end
        end
    end

    else if(in_valid) begin
        IFM[0][0] <= In_IFM_1;
        IFM[0][1] <= In_IFM_2;
        IFM[0][2] <= In_IFM_3;
        IFM[0][3] <= In_IFM_4;
        IFM[0][4] <= In_IFM_5;
        IFM[0][5] <= In_IFM_6;
        IFM[0][6] <= In_IFM_7;
        IFM[0][7] <= In_IFM_8;
        IFM[1][0] <= In_IFM_9;
        IFM[1][1] <= In_IFM_10;
        IFM[1][2] <= In_IFM_11;
        IFM[1][3] <= In_IFM_12;
        IFM[1][4] <= In_IFM_13;
        IFM[1][5] <= In_IFM_14;
        IFM[1][6] <= In_IFM_15;
        IFM[1][7] <= In_IFM_16;
        IFM[2][0] <= In_IFM_17;
        IFM[2][1] <= In_IFM_18;
        IFM[2][2] <= In_IFM_19;
        IFM[2][3] <= In_IFM_20;
        IFM[2][4] <= In_IFM_21;
        IFM[2][5] <= In_IFM_22;
        IFM[2][6] <= In_IFM_23;
        IFM[2][7] <= In_IFM_24;
        IFM[3][0] <= In_IFM_25;
        IFM[3][1] <= In_IFM_26;
        IFM[3][2] <= In_IFM_27;
        IFM[3][3] <= In_IFM_28;
        IFM[3][4] <= In_IFM_29;
        IFM[3][5] <= In_IFM_30;
        IFM[3][6] <= In_IFM_31;
        IFM[3][7] <= In_IFM_32;
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        out_valid <= 0;
    else if(current_state_3)
        out_valid <= 1;
    else
        out_valid <= 0;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    for(i=0;i<4;i=i+1) begin
      for(j=0;j<8;j=j+1) begin
        MUL_Buffer[i][j] <=0;
      end
    end
  end
  else if(current_state) begin
        MUL_Buffer[0][0] <= IFM[0][0]*Weight[0][0];
        MUL_Buffer[0][1] <= IFM[0][1]*Weight[0][1];
        MUL_Buffer[0][2] <= IFM[0][2]*Weight[0][2];
        MUL_Buffer[0][3] <= IFM[0][3]*Weight[0][3];
        MUL_Buffer[0][4] <= IFM[0][4]*Weight[0][4];
        MUL_Buffer[0][5] <= IFM[0][5]*Weight[0][5];
        MUL_Buffer[0][6] <= IFM[0][6]*Weight[0][6];
        MUL_Buffer[0][7] <= IFM[0][7]*Weight[0][7];
        MUL_Buffer[1][0] <= IFM[1][0]*Weight[1][0];
        MUL_Buffer[1][1] <= IFM[1][1]*Weight[1][1];
        MUL_Buffer[1][2] <= IFM[1][2]*Weight[1][2];
        MUL_Buffer[1][3] <= IFM[1][3]*Weight[1][3];
        MUL_Buffer[1][4] <= IFM[1][4]*Weight[1][4];
        MUL_Buffer[1][5] <= IFM[1][5]*Weight[1][5];
        MUL_Buffer[1][6] <= IFM[1][6]*Weight[1][6];
        MUL_Buffer[1][7] <= IFM[1][7]*Weight[1][7];
        MUL_Buffer[2][0] <= IFM[2][0]*Weight[2][0];
        MUL_Buffer[2][1] <= IFM[2][1]*Weight[2][1];
        MUL_Buffer[2][2] <= IFM[2][2]*Weight[2][2];
        MUL_Buffer[2][3] <= IFM[2][3]*Weight[2][3];
        MUL_Buffer[2][4] <= IFM[2][4]*Weight[2][4];
        MUL_Buffer[2][5] <= IFM[2][5]*Weight[2][5];
        MUL_Buffer[2][6] <= IFM[2][6]*Weight[2][6];
        MUL_Buffer[2][7] <= IFM[2][7]*Weight[2][7];
        MUL_Buffer[3][0] <= IFM[3][0]*Weight[3][0];
        MUL_Buffer[3][1] <= IFM[3][1]*Weight[3][1];
        MUL_Buffer[3][2] <= IFM[3][2]*Weight[3][2];
        MUL_Buffer[3][3] <= IFM[3][3]*Weight[3][3];
        MUL_Buffer[3][4] <= IFM[3][4]*Weight[3][4];
        MUL_Buffer[3][5] <= IFM[3][5]*Weight[3][5];
        MUL_Buffer[3][6] <= IFM[3][6]*Weight[3][6];
        MUL_Buffer[3][7] <= IFM[3][7]*Weight[3][7];
        
  end
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    for(i=0;i<4;i=i+1) begin
      for(j=0;j<4;j=j+1) begin
        Adder_Buffer[i][j] <= 0;
      end
    end
  end
  else if(current_state_2) begin
      Adder_Buffer[0][0] <= MUL_Buffer[0][0] + MUL_Buffer[0][1];
      Adder_Buffer[0][1] <= MUL_Buffer[0][2] + MUL_Buffer[0][3];
      Adder_Buffer[0][2] <= MUL_Buffer[0][4] + MUL_Buffer[0][5];
      Adder_Buffer[0][3] <= MUL_Buffer[0][6] + MUL_Buffer[0][7];
      Adder_Buffer[1][0] <= MUL_Buffer[1][0] + MUL_Buffer[1][1];
      Adder_Buffer[1][1] <= MUL_Buffer[1][2] + MUL_Buffer[1][3];
      Adder_Buffer[1][2] <= MUL_Buffer[1][4] + MUL_Buffer[1][5];
      Adder_Buffer[1][3] <= MUL_Buffer[1][6] + MUL_Buffer[1][7];
      Adder_Buffer[2][0] <= MUL_Buffer[2][0] + MUL_Buffer[2][1];
      Adder_Buffer[2][1] <= MUL_Buffer[2][2] + MUL_Buffer[2][3];
      Adder_Buffer[2][2] <= MUL_Buffer[2][4] + MUL_Buffer[2][5];
      Adder_Buffer[2][3] <= MUL_Buffer[2][6] + MUL_Buffer[2][7];
      Adder_Buffer[3][0] <= MUL_Buffer[3][0] + MUL_Buffer[3][1];
      Adder_Buffer[3][1] <= MUL_Buffer[3][2] + MUL_Buffer[3][3];
      Adder_Buffer[3][2] <= MUL_Buffer[3][4] + MUL_Buffer[3][5];
      Adder_Buffer[3][3] <= MUL_Buffer[3][6] + MUL_Buffer[3][7];
  end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        Out_OFM <= 0;
    else if(current_state_3) begin
        Out_OFM <= Adder_Buffer[0][0]
        + Adder_Buffer[0][1]
        + Adder_Buffer[0][2]
        + Adder_Buffer[0][3]
        + Adder_Buffer[1][0]
        + Adder_Buffer[1][1]
        + Adder_Buffer[1][2]
        + Adder_Buffer[1][3]
        + Adder_Buffer[2][0]
        + Adder_Buffer[2][1]
        + Adder_Buffer[2][2]
        + Adder_Buffer[2][3]
        + Adder_Buffer[3][0]
        + Adder_Buffer[3][1]
        + Adder_Buffer[3][2]
        + Adder_Buffer[3][3];
    end
    else
        Out_OFM <= 0;
end

endmodule
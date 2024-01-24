//synopsys translate_on
`include "asap7sc7p5t_SEQ_RVT_TT_08302018.v"
//synopsys translate_off

module Convolution(
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

    In_Weight_1,
    In_Weight_2,
    In_Weight_3,
    In_Weight_4,
    In_Weight_5,
    In_Weight_6,
    In_Weight_7,
    In_Weight_8,
    In_Weight_9,
    In_Weight_10,
    In_Weight_11,
    In_Weight_12,
    In_Weight_13,
    In_Weight_14,
    In_Weight_15,
    In_Weight_16,
    In_Weight_17,
    In_Weight_18,
    In_Weight_19,
    In_Weight_20,
    In_Weight_21,
    In_Weight_22,
    In_Weight_23,
    In_Weight_24,
    In_Weight_25,
    In_Weight_26,
    In_Weight_27,
    In_Weight_28,
    In_Weight_29,
    In_Weight_30,
    In_Weight_31,
    In_Weight_32,

    //output
    out_valid, 
    Out_OFM
);

input clk, rst_n, in_valid, weight_valid;
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

input [3:0]In_Weight_1;
input [3:0]In_Weight_2;
input [3:0]In_Weight_3;
input [3:0]In_Weight_4;
input [3:0]In_Weight_5;
input [3:0]In_Weight_6;
input [3:0]In_Weight_7;
input [3:0]In_Weight_8;
input [3:0]In_Weight_9;
input [3:0]In_Weight_10;
input [3:0]In_Weight_11;
input [3:0]In_Weight_12;
input [3:0]In_Weight_13;
input [3:0]In_Weight_14;
input [3:0]In_Weight_15;
input [3:0]In_Weight_16;
input [3:0]In_Weight_17;
input [3:0]In_Weight_18;
input [3:0]In_Weight_19;
input [3:0]In_Weight_20;
input [3:0]In_Weight_21;
input [3:0]In_Weight_22;
input [3:0]In_Weight_23;
input [3:0]In_Weight_24;
input [3:0]In_Weight_25;
input [3:0]In_Weight_26;
input [3:0]In_Weight_27;
input [3:0]In_Weight_28;
input [3:0]In_Weight_29;
input [3:0]In_Weight_30;
input [3:0]In_Weight_31;
input [3:0]In_Weight_32;

reg [7:0]MUL_Buffer[0:31];
reg [8:0]Adder_Buffer[0:15];

output reg out_valid;
output reg [12:0] Out_OFM;

reg [2:0] state_cs, state_ns;
parameter IDLE = 2'd0;
parameter EXE = 2'd1;

reg [3:0] IFM[0:31];
reg [3:0] Weight[0:31];

reg [6:0] count_out;

integer i;

wire ENA_1;
wire Enable_1;
wire clk_gate_1;
reg Enable_out_1;

/////////////////////////////////////////////
assign Enable_1 = (In_IFM_1==0 && In_IFM_2==0 && In_IFM_3==0 && In_IFM_4==0 && In_IFM_5==0 && In_IFM_6==0 && In_IFM_7==0 && In_IFM_8==0 && In_IFM_9==0 && In_IFM_10==0 && In_IFM_11==0 && In_IFM_12==0 && In_IFM_13==0 && In_IFM_14==0 && In_IFM_15==0 && In_IFM_16==0 && In_IFM_17==0 && In_IFM_18==0 && In_IFM_19==0 && In_IFM_20==0 && In_IFM_21==0 && In_IFM_22==0 && In_IFM_23==0 && In_IFM_24==0 && In_IFM_25==0 && In_IFM_26==0 && In_IFM_27==0 && In_IFM_28==0 && In_IFM_29==0 && In_IFM_30==0 && In_IFM_31==0 && In_IFM_32==0) ? 0 : 1;

assign ENA_1 = 0;

// Clock Gating cells
ICGx3_ASAP7_75t_R CG1(
    //Input signals
    .CLK(clk), 
    .ENA(ENA_1),
    .SE(Enable_1), 
    //Output signal
    .GCLK(clk_gate_1)
);

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		Enable_out_1 <= 0;
	end
	else  begin
		Enable_out_1 <= Enable_1;
	end
end

/////////////////////////////////////////////

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        state_cs <= IDLE;
    else
        state_cs <= state_ns;
end

always@(*) begin
    case(state_cs)
        IDLE:
            begin
            if(in_valid)
                state_ns = EXE;
            else
                state_ns = IDLE;
            end
        EXE:
            begin
            if(count_out == 51)
                state_ns = IDLE;
            else
                state_ns = EXE;
            end
        default:
            state_ns = IDLE;
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<32; i=i+1) begin
            Weight[i] <= 0;
        end
    end

    else if(weight_valid) begin
        Weight[0] <= In_Weight_1;
        Weight[1] <= In_Weight_2;
        Weight[2] <= In_Weight_3;
        Weight[3] <= In_Weight_4;
        Weight[4] <= In_Weight_5;
        Weight[5] <= In_Weight_6;
        Weight[6] <= In_Weight_7;
        Weight[7] <= In_Weight_8;
        Weight[8] <= In_Weight_9;
        Weight[9] <= In_Weight_10;
        Weight[10] <= In_Weight_11;
        Weight[11] <= In_Weight_12;
        Weight[12] <= In_Weight_13;
        Weight[13] <= In_Weight_14;
        Weight[14] <= In_Weight_15;
        Weight[15] <= In_Weight_16;
        Weight[16] <= In_Weight_17;
        Weight[17] <= In_Weight_18;
        Weight[18] <= In_Weight_19;
        Weight[19] <= In_Weight_20;
        Weight[20] <= In_Weight_21;
        Weight[21] <= In_Weight_22;
        Weight[22] <= In_Weight_23;
        Weight[23] <= In_Weight_24;
        Weight[24] <= In_Weight_25;
        Weight[25] <= In_Weight_26;
        Weight[26] <= In_Weight_27;
        Weight[27] <= In_Weight_28;
        Weight[28] <= In_Weight_29;
        Weight[29] <= In_Weight_30;
        Weight[30] <= In_Weight_31;
        Weight[31] <= In_Weight_32;
    end
end

always@(posedge clk_gate_1 or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<32; i=i+1) begin
            IFM[i] <= 0;
        end
    end

    else if(Enable_1) begin
        IFM[0] <= In_IFM_1;
        IFM[1] <= In_IFM_2;
        IFM[2] <= In_IFM_3;
        IFM[3] <= In_IFM_4;
        IFM[4] <= In_IFM_5;
        IFM[5] <= In_IFM_6;
        IFM[6] <= In_IFM_7;
        IFM[7] <= In_IFM_8;
        IFM[8] <= In_IFM_9;
        IFM[9] <= In_IFM_10;
        IFM[10] <= In_IFM_11;
        IFM[11] <= In_IFM_12;
        IFM[12] <= In_IFM_13;
        IFM[13] <= In_IFM_14;
        IFM[14] <= In_IFM_15;
        IFM[15] <= In_IFM_16;
        IFM[16] <= In_IFM_17;
        IFM[17] <= In_IFM_18;
        IFM[18] <= In_IFM_19;
        IFM[19] <= In_IFM_20;
        IFM[20] <= In_IFM_21;
        IFM[21] <= In_IFM_22;
        IFM[22] <= In_IFM_23;
        IFM[23] <= In_IFM_24;
        IFM[24] <= In_IFM_25;
        IFM[25] <= In_IFM_26;
        IFM[26] <= In_IFM_27;
        IFM[27] <= In_IFM_28;
        IFM[28] <= In_IFM_29;
        IFM[29] <= In_IFM_30;
        IFM[30] <= In_IFM_31;
        IFM[31] <= In_IFM_32;
    end
    else begin
        IFM[0] <= IFM[0];
        IFM[1] <= IFM[1];
        IFM[2] <= IFM[2];
        IFM[3] <= IFM[3];
        IFM[4] <= IFM[4];
        IFM[5] <= IFM[5];
        IFM[6] <= IFM[6];
        IFM[7] <= IFM[7];
        IFM[8] <= IFM[8];
        IFM[9] <= IFM[9];
        IFM[10] <= IFM[10];
        IFM[11] <= IFM[11];
        IFM[12] <= IFM[12];
        IFM[13] <= IFM[13];
        IFM[14] <= IFM[14];
        IFM[15] <= IFM[15];
        IFM[16] <= IFM[16];
        IFM[17] <= IFM[17];
        IFM[18] <= IFM[18];
        IFM[19] <= IFM[19];
        IFM[20] <= IFM[20];
        IFM[21] <= IFM[21];
        IFM[22] <= IFM[22];
        IFM[23] <= IFM[23];
        IFM[24] <= IFM[24];
        IFM[25] <= IFM[25];
        IFM[26] <= IFM[26];
        IFM[27] <= IFM[27];
        IFM[28] <= IFM[28];
        IFM[29] <= IFM[29];
        IFM[30] <= IFM[30];
        IFM[31] <= IFM[31];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        count_out <= 0;
    else if(state_cs == EXE)
        count_out <= count_out + 1;
    else
        count_out <= 0;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        out_valid <= 0;
    else if(state_cs == EXE && count_out >1)
        out_valid <= 1;
    else
        out_valid <= 0;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    for(i=0;i<32;i=i+1) begin
      MUL_Buffer[i] <=0;
    end
  end
  else if(state_cs == EXE) begin
    for(i=0;i<32;i=i+1) begin
      MUL_Buffer[i] <= IFM[i] * Weight[i];
    end
  end
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    for(i=0;i<16;i=i+1) begin
      Adder_Buffer[i] <=0;
    end
  end
  else if(state_cs == EXE) begin
      Adder_Buffer[0] <= MUL_Buffer[0] + MUL_Buffer[1];
      Adder_Buffer[1] <= MUL_Buffer[2] + MUL_Buffer[3];
      Adder_Buffer[2] <= MUL_Buffer[4] + MUL_Buffer[5];
      Adder_Buffer[3] <= MUL_Buffer[6] + MUL_Buffer[7];
      Adder_Buffer[4] <= MUL_Buffer[8] + MUL_Buffer[9];
      Adder_Buffer[5] <= MUL_Buffer[10] + MUL_Buffer[11];
      Adder_Buffer[6] <= MUL_Buffer[12] + MUL_Buffer[13];
      Adder_Buffer[7] <= MUL_Buffer[14] + MUL_Buffer[15];
      Adder_Buffer[8] <= MUL_Buffer[16] + MUL_Buffer[17];
      Adder_Buffer[9] <= MUL_Buffer[18] + MUL_Buffer[19];
      Adder_Buffer[10] <= MUL_Buffer[20] + MUL_Buffer[21];
      Adder_Buffer[11] <= MUL_Buffer[22] + MUL_Buffer[23];
      Adder_Buffer[12] <= MUL_Buffer[24] + MUL_Buffer[25];
      Adder_Buffer[13] <= MUL_Buffer[26] + MUL_Buffer[27];
      Adder_Buffer[14] <= MUL_Buffer[28] + MUL_Buffer[29];
      Adder_Buffer[15] <= MUL_Buffer[30] + MUL_Buffer[31];

  end
end


always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        Out_OFM <= 0;
    else if(state_cs == EXE) begin
        Out_OFM <= Adder_Buffer[0]
        + Adder_Buffer[1]
        + Adder_Buffer[2]
        + Adder_Buffer[3]
        + Adder_Buffer[4]
        + Adder_Buffer[5]
        + Adder_Buffer[6]
        + Adder_Buffer[7]
        + Adder_Buffer[8]
        + Adder_Buffer[9]
        + Adder_Buffer[10]
        + Adder_Buffer[11]
        + Adder_Buffer[12]
        + Adder_Buffer[13]
        + Adder_Buffer[14]
        + Adder_Buffer[15];
    end
    else
        Out_OFM <= 0;
end

endmodule






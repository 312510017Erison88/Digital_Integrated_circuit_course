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

reg [2:0] state_cs, state_ns;
parameter IDLE = 3'd0;
parameter EXE = 3'd2;

reg [7:0] IFM[0:8];
reg [7:0] Weight[0:8];

reg [4:0] count_out;

integer i;

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
            if(count_out == 24)
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
        for(i=0; i<8; i=i+1) begin
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
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<8; i=i+1) begin
            IFM[i] <= 0;
        end
    end

    else if(in_valid) begin
        IFM[0] <= In_IFM_1 ;
        IFM[1] <= In_IFM_2 ;
        IFM[2] <= In_IFM_3 ;
        IFM[3] <= In_IFM_4 ;
        IFM[4] <= In_IFM_5 ;
        IFM[5] <= In_IFM_6 ;
        IFM[6] <= In_IFM_7 ;
        IFM[7] <= In_IFM_8 ;
        IFM[8] <= In_IFM_9 ;
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
    else if(state_cs == EXE)
        out_valid <= 1;
    else
        out_valid <= 0;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        Out_OFM <= 0;
    else if(state_cs == EXE) begin
        Out_OFM <= IFM[0]*Weight[0]
            +IFM[1]*Weight[1]
            +IFM[2]*Weight[2]
            +IFM[3]*Weight[3]
            +IFM[4]*Weight[4]
            +IFM[5]*Weight[5]
            +IFM[6]*Weight[6]
            +IFM[7]*Weight[7]
            +IFM[8]*Weight[8];
    end
    else
        Out_OFM <= 0;
end

endmodule

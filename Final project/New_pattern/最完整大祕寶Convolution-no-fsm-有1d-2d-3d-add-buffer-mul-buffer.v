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

reg [7:0]MUL_Buffer[0:31];
//reg [7:0]MUL_Buffer[0:3][0:7];
//reg [8:0]Adder_Buffer[0:3][0:4];

//reg [7:0]MUL_Buffer[0:1][0:3][0:3];




output reg out_valid;
output reg [12:0] Out_OFM;

reg [3:0]IFM_Buffer[0:31]; 
reg [3:0]Weight_Buffer[0:31]; 

//reg [3:0] IFM[0:3][0:7];
//reg [3:0] Weight[0:3][0:7];

//reg [3:0] IFM[0:1][0:3][0:3];
//reg [3:0] Weight[0:1][0:3][0:3];


// reg [7:0] count_out;
reg current_state;
reg current_state_2;
//reg current_state_3;
wire next_state;

integer i,j,k;

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

//always@(posedge clk or negedge rst_n) begin
//	if(!rst_n)
//		current_state_3 <= 0;
//	else
//		current_state_3 <= current_state_2;
//end

// always@(posedge clk or negedge rst_n) begin
//     if(!rst_n) begin
//         for(i=0; i<4; i=i+1) begin
//           for(j=0; j<8; j=j+1) begin
//             Weight[i][j] <= 0;
//           end
//         end
//     end

//     else if(weight_valid) begin
//         Weight[0][0] <= In_Weight_1;
//         Weight[0][1] <= In_Weight_2;
//         Weight[0][2] <= In_Weight_3;
//         Weight[0][3] <= In_Weight_4;
//         Weight[0][4] <= In_Weight_5;
//         Weight[0][5] <= In_Weight_6;
//         Weight[0][6] <= In_Weight_7;
//         Weight[0][7] <= In_Weight_8;
//         Weight[1][0] <= In_Weight_9;
//         Weight[1][1] <= In_Weight_10;
//         Weight[1][2] <= In_Weight_11;
//         Weight[1][3] <= In_Weight_12;
//         Weight[1][4] <= In_Weight_13;
//         Weight[1][5] <= In_Weight_14;
//         Weight[1][6] <= In_Weight_15;
//         Weight[1][7] <= In_Weight_16;
//         Weight[2][0] <= In_Weight_17;
//         Weight[2][1] <= In_Weight_18;
//         Weight[2][2] <= In_Weight_19;
//         Weight[2][3] <= In_Weight_20;
//         Weight[2][4] <= In_Weight_21;
//         Weight[2][5] <= In_Weight_22;
//         Weight[2][6] <= In_Weight_23;
//         Weight[2][7] <= In_Weight_24;
//         Weight[3][0] <= In_Weight_25;
//         Weight[3][1] <= In_Weight_26;
//         Weight[3][2] <= In_Weight_27;
//         Weight[3][3] <= In_Weight_28;
//         Weight[3][4] <= In_Weight_29;
//         Weight[3][5] <= In_Weight_30;
//         Weight[3][6] <= In_Weight_31;
//         Weight[3][7] <= In_Weight_32;
//     end
// end

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



//always@(posedge clk or negedge rst_n) begin
//	if(!rst_n) begin
//		Weight[0][0]  <= 4'd6;
//		Weight[0][1]  <= 4'd14;
//		Weight[0][2]  <= 4'd13;
//		Weight[0][3]  <= 4'd10;
//		Weight[0][4]  <= 4'd10;
//		Weight[0][5]  <= 4'd14;
//		Weight[0][6]  <= 4'd3;
//		Weight[0][7]  <= 4'd4;
//		Weight[1][0]  <= 4'd0;
//		Weight[1][1]  <= 4'd6;
//		Weight[1][2]  <= 4'd7;
//		Weight[1][3]  <= 4'd9;
//		Weight[1][4]  <= 4'd11;
//		Weight[1][5]  <= 4'd12;
//		Weight[1][6]  <= 4'd6;
//		Weight[1][7]  <= 4'd3;
//		Weight[2][0]  <= 4'd2;
//		Weight[2][1]  <= 4'd1;
//		Weight[2][2]  <= 4'd5;
//		Weight[2][3]  <= 4'd8;
//		Weight[2][4]  <= 4'd7;
//		Weight[2][5]  <= 4'd13;
//		Weight[2][6]  <= 4'd1;
//		Weight[2][7]  <= 4'd8;
//		Weight[3][0]  <= 4'd7;
//		Weight[3][1]  <= 4'd12;
//		Weight[3][2]  <= 4'd13;
//		Weight[3][3]  <= 4'd10;
//		Weight[3][4]  <= 4'd10;
//		Weight[3][5]  <= 4'd9;
//		Weight[3][6]  <= 4'd7;
//		Weight[3][7]  <= 4'd7;
//	end
//end


//always@(posedge clk or negedge rst_n) begin
//	if(!rst_n) begin
//		Weight[0][0][0]  <= 4'd6;
//		Weight[0][0][1]  <= 4'd14;
//		Weight[0][0][2]  <= 4'd13;
//		Weight[0][0][3]  <= 4'd10;
//		Weight[0][1][0]  <= 4'd10;
//		Weight[0][1][1]  <= 4'd14;
//		Weight[0][1][2]  <= 4'd3;
//		Weight[0][1][3]  <= 4'd4;
//		Weight[0][2][0]  <= 4'd0;
//		Weight[0][2][1]  <= 4'd6;
//		Weight[0][2][2]  <= 4'd7;
//		Weight[0][2][3]  <= 4'd9;
//		Weight[0][3][0]  <= 4'd11;
//		Weight[0][3][1]  <= 4'd12;
//		Weight[0][3][2]  <= 4'd6;
//		Weight[0][3][3]  <= 4'd3;
//		Weight[1][0][0]  <= 4'd2;
//		Weight[1][0][1]  <= 4'd1;
//		Weight[1][0][2]  <= 4'd5;
//		Weight[1][0][3]  <= 4'd8;
//		Weight[1][1][0]  <= 4'd7;
//		Weight[1][1][1]  <= 4'd13;
//		Weight[1][1][2]  <= 4'd1;
//		Weight[1][1][3]  <= 4'd8;
//		Weight[1][2][0]  <= 4'd7;
//		Weight[1][2][1]  <= 4'd12;
//		Weight[1][2][2]  <= 4'd13;
//		Weight[1][2][3]  <= 4'd10;
//		Weight[1][3][0]  <= 4'd10;
//		Weight[1][3][1]  <= 4'd9;
//		Weight[1][3][2]  <= 4'd7;
//		Weight[1][3][3]  <= 4'd7;
//	end
//end

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) begin
//        for(i=0; i<4; i=i+1) begin
//          for(j=0; j<8; j=j+1) begin
//            IFM[i][j] <= 0;
//          end
//        end
//    end
//
//    else if(in_valid) begin
//        IFM[0][0] <= In_IFM_1;
//        IFM[0][1] <= In_IFM_2;
//        IFM[0][2] <= In_IFM_3;
//        IFM[0][3] <= In_IFM_4;
//        IFM[0][4] <= In_IFM_5;
//        IFM[0][5] <= In_IFM_6;
//        IFM[0][6] <= In_IFM_7;
//        IFM[0][7] <= In_IFM_8;
//        IFM[1][0] <= In_IFM_9;
//        IFM[1][1] <= In_IFM_10;
//        IFM[1][2] <= In_IFM_11;
//        IFM[1][3] <= In_IFM_12;
//        IFM[1][4] <= In_IFM_13;
//        IFM[1][5] <= In_IFM_14;
//        IFM[1][6] <= In_IFM_15;
//        IFM[1][7] <= In_IFM_16;
//        IFM[2][0] <= In_IFM_17;
//        IFM[2][1] <= In_IFM_18;
//        IFM[2][2] <= In_IFM_19;
//        IFM[2][3] <= In_IFM_20;
//        IFM[2][4] <= In_IFM_21;
//        IFM[2][5] <= In_IFM_22;
//        IFM[2][6] <= In_IFM_23;
//        IFM[2][7] <= In_IFM_24;
//        IFM[3][0] <= In_IFM_25;
//        IFM[3][1] <= In_IFM_26;
//        IFM[3][2] <= In_IFM_27;
//        IFM[3][3] <= In_IFM_28;
//        IFM[3][4] <= In_IFM_29;
//        IFM[3][5] <= In_IFM_30;
//        IFM[3][6] <= In_IFM_31;
//        IFM[3][7] <= In_IFM_32;
//    end
//end

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n) begin
//    for(i=0;i<2;i=i+1) begin
//      for(j=0;j<4;j=j+1) begin
//        for(k=0; k<4; k=k+1) begin
//          IFM[i][j][k] <=0;
//        end
//      end
//    end
//    end
//
//    else if(in_valid) begin
//        IFM[0][0][0] <= In_IFM_1;
//        IFM[0][0][1] <= In_IFM_2;
//        IFM[0][0][2] <= In_IFM_3;
//        IFM[0][0][3] <= In_IFM_4;
//        IFM[0][1][0] <= In_IFM_5;
//        IFM[0][1][1] <= In_IFM_6;
//        IFM[0][1][2] <= In_IFM_7;
//        IFM[0][1][3] <= In_IFM_8;
//        IFM[0][2][0] <= In_IFM_9;
//        IFM[0][2][1] <= In_IFM_10;
//        IFM[0][2][2] <= In_IFM_11;
//        IFM[0][2][3] <= In_IFM_12;
//        IFM[0][3][0] <= In_IFM_13;
//        IFM[0][3][1] <= In_IFM_14;
//        IFM[0][3][2] <= In_IFM_15;
//        IFM[0][3][3] <= In_IFM_16;
//        IFM[1][0][0] <= In_IFM_17;
//        IFM[1][0][1] <= In_IFM_18;
//        IFM[1][0][2] <= In_IFM_19;
//        IFM[1][0][3] <= In_IFM_20;
//        IFM[1][1][0] <= In_IFM_21;
//        IFM[1][1][1] <= In_IFM_22;
//        IFM[1][1][2] <= In_IFM_23;
//        IFM[1][1][3] <= In_IFM_24;
//        IFM[1][2][0] <= In_IFM_25;
//        IFM[1][2][1] <= In_IFM_26;
//        IFM[1][2][2] <= In_IFM_27;
//        IFM[1][2][3] <= In_IFM_28;
//        IFM[1][3][0] <= In_IFM_29;
//        IFM[1][3][1] <= In_IFM_30;
//        IFM[1][3][2] <= In_IFM_31;
//        IFM[1][3][3] <= In_IFM_32;
//    end
//end




always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        out_valid <= 0;
    else if(current_state_2)
        out_valid <= 1;
    else
        out_valid <= 0;
end

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		for(i=0;i<32;i=i+1) begin
			MUL_Buffer[i] <= 0;
		end
	end
	else if(current_state) begin
		MUL_Buffer[0] <= IFM_Buffer[0]*Weight_Buffer[0];
		MUL_Buffer[1] <= IFM_Buffer[1]*Weight_Buffer[1];
		MUL_Buffer[2] <= IFM_Buffer[2]*Weight_Buffer[2];
		MUL_Buffer[3] <= IFM_Buffer[3]*Weight_Buffer[3];
		MUL_Buffer[4] <= IFM_Buffer[4]*Weight_Buffer[4];
		MUL_Buffer[5] <= IFM_Buffer[5]*Weight_Buffer[5];
		MUL_Buffer[6] <= IFM_Buffer[6]*Weight_Buffer[6];
		MUL_Buffer[7] <= IFM_Buffer[7]*Weight_Buffer[7];
		MUL_Buffer[8] <= IFM_Buffer[8]*Weight_Buffer[8];
		MUL_Buffer[9] <= IFM_Buffer[9]*Weight_Buffer[9];
		MUL_Buffer[10] <= IFM_Buffer[10]*Weight_Buffer[10];
		MUL_Buffer[11] <= IFM_Buffer[11]*Weight_Buffer[11];
		MUL_Buffer[12] <= IFM_Buffer[12]*Weight_Buffer[12];
		MUL_Buffer[13] <= IFM_Buffer[13]*Weight_Buffer[13];
		MUL_Buffer[14] <= IFM_Buffer[14]*Weight_Buffer[14];
		MUL_Buffer[15] <= IFM_Buffer[15]*Weight_Buffer[15];
		MUL_Buffer[16] <= IFM_Buffer[16]*Weight_Buffer[16];
		MUL_Buffer[17] <= IFM_Buffer[17]*Weight_Buffer[17];
		MUL_Buffer[18] <= IFM_Buffer[18]*Weight_Buffer[18];
		MUL_Buffer[19] <= IFM_Buffer[19]*Weight_Buffer[19];
		MUL_Buffer[20] <= IFM_Buffer[20]*Weight_Buffer[20];
		MUL_Buffer[21] <= IFM_Buffer[21]*Weight_Buffer[21];
		MUL_Buffer[22] <= IFM_Buffer[22]*Weight_Buffer[22];
		MUL_Buffer[23] <= IFM_Buffer[23]*Weight_Buffer[23];
		MUL_Buffer[24] <= IFM_Buffer[24]*Weight_Buffer[24];
		MUL_Buffer[25] <= IFM_Buffer[25]*Weight_Buffer[25];
		MUL_Buffer[26] <= IFM_Buffer[26]*Weight_Buffer[26];
		MUL_Buffer[27] <= IFM_Buffer[27]*Weight_Buffer[27];
		MUL_Buffer[28] <= IFM_Buffer[28]*Weight_Buffer[28];
		MUL_Buffer[29] <= IFM_Buffer[29]*Weight_Buffer[29];
		MUL_Buffer[30] <= IFM_Buffer[30]*Weight_Buffer[30];
		MUL_Buffer[31] <= IFM_Buffer[31]*Weight_Buffer[31];
	end
end

//always @(posedge clk or negedge rst_n) begin
//  if (!rst_n) begin
//    for(i=0;i<4;i=i+1) begin
//      for(j=0;j<8;j=j+1) begin
//        MUL_Buffer[i][j] <=0;
//      end
//    end
//  end
//  else if(current_state) begin
//        MUL_Buffer[0][0] <= IFM[0][0]*Weight[0][0];
//        MUL_Buffer[0][1] <= IFM[0][1]*Weight[0][1];
//        MUL_Buffer[0][2] <= IFM[0][2]*Weight[0][2];
//        MUL_Buffer[0][3] <= IFM[0][3]*Weight[0][3];
//        MUL_Buffer[0][4] <= IFM[0][4]*Weight[0][4];
//        MUL_Buffer[0][5] <= IFM[0][5]*Weight[0][5];
//        MUL_Buffer[0][6] <= IFM[0][6]*Weight[0][6];
//        MUL_Buffer[0][7] <= IFM[0][7]*Weight[0][7];
//        MUL_Buffer[1][0] <= IFM[1][0]*Weight[1][0];
//        MUL_Buffer[1][1] <= IFM[1][1]*Weight[1][1];
//        MUL_Buffer[1][2] <= IFM[1][2]*Weight[1][2];
//        MUL_Buffer[1][3] <= IFM[1][3]*Weight[1][3];
//        MUL_Buffer[1][4] <= IFM[1][4]*Weight[1][4];
//        MUL_Buffer[1][5] <= IFM[1][5]*Weight[1][5];
//        MUL_Buffer[1][6] <= IFM[1][6]*Weight[1][6];
//        MUL_Buffer[1][7] <= IFM[1][7]*Weight[1][7];
//        MUL_Buffer[2][0] <= IFM[2][0]*Weight[2][0];
//        MUL_Buffer[2][1] <= IFM[2][1]*Weight[2][1];
//        MUL_Buffer[2][2] <= IFM[2][2]*Weight[2][2];
//        MUL_Buffer[2][3] <= IFM[2][3]*Weight[2][3];
//        MUL_Buffer[2][4] <= IFM[2][4]*Weight[2][4];
//        MUL_Buffer[2][5] <= IFM[2][5]*Weight[2][5];
//        MUL_Buffer[2][6] <= IFM[2][6]*Weight[2][6];
//        MUL_Buffer[2][7] <= IFM[2][7]*Weight[2][7];
//        MUL_Buffer[3][0] <= IFM[3][0]*Weight[3][0];
//        MUL_Buffer[3][1] <= IFM[3][1]*Weight[3][1];
//        MUL_Buffer[3][2] <= IFM[3][2]*Weight[3][2];
//        MUL_Buffer[3][3] <= IFM[3][3]*Weight[3][3];
//        MUL_Buffer[3][4] <= IFM[3][4]*Weight[3][4];
//        MUL_Buffer[3][5] <= IFM[3][5]*Weight[3][5];
//        MUL_Buffer[3][6] <= IFM[3][6]*Weight[3][6];
//        MUL_Buffer[3][7] <= IFM[3][7]*Weight[3][7];
//        
//  end
//end

//always @(posedge clk or negedge rst_n) begin
//  if (!rst_n) begin
//    for(i=0;i<2;i=i+1) begin
//      for(j=0;j<4;j=j+1) begin
//        for(k=0; k<4; k=k+1) begin
//          MUL_Buffer[i][j][k] <=0;
//        end
//      end
//    end
//  end
//  else if(current_state) begin
//        MUL_Buffer[0][0][0] <= IFM[0][0][0]*Weight[0][0][0];
//        MUL_Buffer[0][0][1] <= IFM[0][0][1]*Weight[0][0][1];
//        MUL_Buffer[0][0][2] <= IFM[0][0][2]*Weight[0][0][2];
//        MUL_Buffer[0][0][3] <= IFM[0][0][3]*Weight[0][0][3];
//        MUL_Buffer[0][1][0] <= IFM[0][1][0]*Weight[0][1][0];
//        MUL_Buffer[0][1][1] <= IFM[0][1][1]*Weight[0][1][1];
//        MUL_Buffer[0][1][2] <= IFM[0][1][2]*Weight[0][1][2];
//        MUL_Buffer[0][1][3] <= IFM[0][1][3]*Weight[0][1][3];
//        MUL_Buffer[0][2][0] <= IFM[0][2][0]*Weight[0][2][0];
//        MUL_Buffer[0][2][1] <= IFM[0][2][1]*Weight[0][2][1];
//        MUL_Buffer[0][2][2] <= IFM[0][2][2]*Weight[0][2][2];
//        MUL_Buffer[0][2][3] <= IFM[0][2][3]*Weight[0][2][3];
//        MUL_Buffer[0][3][0] <= IFM[0][3][0]*Weight[0][3][0];
//        MUL_Buffer[0][3][1] <= IFM[0][3][1]*Weight[0][3][1];
//        MUL_Buffer[0][3][2] <= IFM[0][3][2]*Weight[0][3][2];
//        MUL_Buffer[0][3][3] <= IFM[0][3][3]*Weight[0][3][3];
//        MUL_Buffer[1][0][0] <= IFM[1][0][0]*Weight[1][0][0];
//        MUL_Buffer[1][0][1] <= IFM[1][0][1]*Weight[1][0][1];
//        MUL_Buffer[1][0][2] <= IFM[1][0][2]*Weight[1][0][2];
//        MUL_Buffer[1][0][3] <= IFM[1][0][3]*Weight[1][0][3];
//        MUL_Buffer[1][1][0] <= IFM[1][1][0]*Weight[1][1][0];
//        MUL_Buffer[1][1][1] <= IFM[1][1][1]*Weight[1][1][1];
//        MUL_Buffer[1][1][2] <= IFM[1][1][2]*Weight[1][1][2];
//        MUL_Buffer[1][1][3] <= IFM[1][1][3]*Weight[1][1][3];
//        MUL_Buffer[1][2][0] <= IFM[1][2][0]*Weight[1][2][0];
//        MUL_Buffer[1][2][1] <= IFM[1][2][1]*Weight[1][2][1];
//        MUL_Buffer[1][2][2] <= IFM[1][2][2]*Weight[1][2][2];
//        MUL_Buffer[1][2][3] <= IFM[1][2][3]*Weight[1][2][3];
//        MUL_Buffer[1][3][0] <= IFM[1][3][0]*Weight[1][3][0];
//        MUL_Buffer[1][3][1] <= IFM[1][3][1]*Weight[1][3][1];
//        MUL_Buffer[1][3][2] <= IFM[1][3][2]*Weight[1][3][2];
//        MUL_Buffer[1][3][3] <= IFM[1][3][3]*Weight[1][3][2];
//        
//  end
//end






//always @(posedge clk or negedge rst_n) begin
//  if (!rst_n) begin
//    for(i=0;i<4;i=i+1) begin
//      for(j=0;j<4;j=j+1) begin
//        Adder_Buffer[i][j] <= 0;
//      end
//    end
//  end
//  else if(current_state_2) begin
//      Adder_Buffer[0][0] <= MUL_Buffer[0][0] + MUL_Buffer[0][1];
//      Adder_Buffer[0][1] <= MUL_Buffer[0][2] + MUL_Buffer[0][3];
//      Adder_Buffer[0][2] <= MUL_Buffer[0][4] + MUL_Buffer[0][5];
//      Adder_Buffer[0][3] <= MUL_Buffer[0][6] + MUL_Buffer[0][7];
//      Adder_Buffer[1][0] <= MUL_Buffer[1][0] + MUL_Buffer[1][1];
//      Adder_Buffer[1][1] <= MUL_Buffer[1][2] + MUL_Buffer[1][3];
//      Adder_Buffer[1][2] <= MUL_Buffer[1][4] + MUL_Buffer[1][5];
//      Adder_Buffer[1][3] <= MUL_Buffer[1][6] + MUL_Buffer[1][7];
//      Adder_Buffer[2][0] <= MUL_Buffer[2][0] + MUL_Buffer[2][1];
//      Adder_Buffer[2][1] <= MUL_Buffer[2][2] + MUL_Buffer[2][3];
//      Adder_Buffer[2][2] <= MUL_Buffer[2][4] + MUL_Buffer[2][5];
//      Adder_Buffer[2][3] <= MUL_Buffer[2][6] + MUL_Buffer[2][7];
//      Adder_Buffer[3][0] <= MUL_Buffer[3][0] + MUL_Buffer[3][1];
//      Adder_Buffer[3][1] <= MUL_Buffer[3][2] + MUL_Buffer[3][3];
//      Adder_Buffer[3][2] <= MUL_Buffer[3][4] + MUL_Buffer[3][5];
//      Adder_Buffer[3][3] <= MUL_Buffer[3][6] + MUL_Buffer[3][7];
//  end
//end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n)
	        Out_OFM <= 0;
	else if(current_state_2) begin
		Out_OFM <= MUL_Buffer[0] +
MUL_Buffer[1] +
MUL_Buffer[2] +
MUL_Buffer[3] +
MUL_Buffer[4] +
MUL_Buffer[5] +
MUL_Buffer[6] +
MUL_Buffer[7] +
MUL_Buffer[8] +
MUL_Buffer[9] +
MUL_Buffer[10] +
MUL_Buffer[11] +
MUL_Buffer[12] +
MUL_Buffer[13] +
MUL_Buffer[14] +
MUL_Buffer[15] +
MUL_Buffer[16] +
MUL_Buffer[17] +
MUL_Buffer[18] +
MUL_Buffer[19] +
MUL_Buffer[20] +
MUL_Buffer[21] +
MUL_Buffer[22] +
MUL_Buffer[23] +
MUL_Buffer[24] +
MUL_Buffer[25] +
MUL_Buffer[26] +
MUL_Buffer[27] +
MUL_Buffer[28] +
MUL_Buffer[29] +
MUL_Buffer[30] +
MUL_Buffer[31];
    end
    else
        Out_OFM <= 0;
end

endmodule







//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        Out_OFM <= 0;
//    else if(current_state_2) begin
//        Out_OFM <= MUL_Buffer[0][0] + MUL_Buffer[0][1] + MUL_Buffer[0][2] + MUL_Buffer[0][3]
//        	 + MUL_Buffer[0][4] + MUL_Buffer[0][5] + MUL_Buffer[0][6] + MUL_Buffer[0][7]
//        	 + MUL_Buffer[1][0] + MUL_Buffer[1][1] + MUL_Buffer[1][2] + MUL_Buffer[1][3]
//        	 + MUL_Buffer[1][4] + MUL_Buffer[1][5] + MUL_Buffer[1][6] + MUL_Buffer[1][7]
//        	 + MUL_Buffer[2][0] + MUL_Buffer[2][1] + MUL_Buffer[2][2] + MUL_Buffer[2][3]
//        	 + MUL_Buffer[2][4] + MUL_Buffer[2][5] + MUL_Buffer[2][6] + MUL_Buffer[2][7]
//        	 + MUL_Buffer[3][0] + MUL_Buffer[3][1] + MUL_Buffer[3][2] + MUL_Buffer[3][3]
//        	 + MUL_Buffer[3][4] + MUL_Buffer[3][5] + MUL_Buffer[3][6] + MUL_Buffer[3][7];
//    end
//    else
//        Out_OFM <= 0;
//end

//endmodule

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        Out_OFM <= 0;
//    else if(current_state_2) begin
//        Out_OFM <= MUL_Buffer[0][0][0] + MUL_Buffer[0][2][0] + MUL_Buffer[1][0][0] + MUL_Buffer[1][2][0] 
//		  +MUL_Buffer[0][0][1] + MUL_Buffer[0][2][1] + MUL_Buffer[1][0][1] + MUL_Buffer[1][2][1] 
//		  +MUL_Buffer[0][0][2] + MUL_Buffer[0][2][2] + MUL_Buffer[1][0][2] + MUL_Buffer[1][2][2] 
//		  +MUL_Buffer[0][0][3] + MUL_Buffer[0][2][3] + MUL_Buffer[1][0][3] + MUL_Buffer[1][2][3] 		
//		  +MUL_Buffer[0][1][0] + MUL_Buffer[0][3][0] + MUL_Buffer[1][1][0] + MUL_Buffer[1][3][0] 
//		  +MUL_Buffer[0][1][1] + MUL_Buffer[0][3][1] + MUL_Buffer[1][1][1] + MUL_Buffer[1][3][1] 
//		  +MUL_Buffer[0][1][2] + MUL_Buffer[0][3][2] + MUL_Buffer[1][1][2] + MUL_Buffer[1][3][2] 
//		  +MUL_Buffer[0][1][3] + MUL_Buffer[0][3][3] + MUL_Buffer[1][1][3] + MUL_Buffer[1][3][3];
//	end
//    else
//        Out_OFM <= 0;
//end

//endmodule

//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        Out_OFM <= 0;
//    else if(current_state) begin
//	Out_OFM <= IFM[0][0]*Weight[0][0] + IFM[0][1]*Weight[0][1] + IFM[0][2]*Weight[0][2] + IFM[0][3]*Weight[0][3]
//		  +IFM[0][4]*Weight[0][4] + IFM[0][5]*Weight[0][5] + IFM[0][6]*Weight[0][6] + IFM[0][7]*Weight[0][7]
//		  +IFM[1][0]*Weight[1][0] + IFM[1][1]*Weight[1][1] + IFM[1][2]*Weight[1][2] + IFM[1][3]*Weight[1][3]
//		  +IFM[1][4]*Weight[1][4] + IFM[1][5]*Weight[1][5] + IFM[1][6]*Weight[1][6] + IFM[1][7]*Weight[1][7]
//		  +IFM[2][0]*Weight[2][0] + IFM[2][1]*Weight[2][1] + IFM[2][2]*Weight[2][2] + IFM[2][3]*Weight[2][3]
//		  +IFM[2][4]*Weight[2][4] + IFM[2][5]*Weight[2][5] + IFM[2][6]*Weight[2][6] + IFM[2][7]*Weight[2][7]
//		  +IFM[3][0]*Weight[3][0] + IFM[3][1]*Weight[3][1] + IFM[3][2]*Weight[3][2] + IFM[3][3]*Weight[3][3]
//		  +IFM[3][4]*Weight[3][4] + IFM[3][5]*Weight[3][5] + IFM[3][6]*Weight[3][6] + IFM[3][7]*Weight[3][7];
//	end
//    else
//        Out_OFM <= 0;
//end

//endmodule



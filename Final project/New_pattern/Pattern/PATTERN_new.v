`define clk_PERIOD 0.570//# the unit of the clk_PERIOD  in here is ns 
`define End_CYCLE 10000
module PATTERN	(
	rst_n,
	clk,
	in_valid,
	//weight_valid,
	//cg_en,
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
	// In_Weight_1,
	// In_Weight_2,
	// In_Weight_3,
	// In_Weight_4,
	// In_Weight_5,
	// In_Weight_6,
	// In_Weight_7,
	// In_Weight_8,
	// In_Weight_9,
    // In_Weight_10,
	// In_Weight_11,
	// In_Weight_12,
	// In_Weight_13,
	// In_Weight_14,
	// In_Weight_15,
	// In_Weight_16,
	// In_Weight_17,
	// In_Weight_18,
    // In_Weight_19,
	// In_Weight_20,
	// In_Weight_21,
	// In_Weight_22,
	// In_Weight_23,
	// In_Weight_24,
	// In_Weight_25,
	// In_Weight_26,
	// In_Weight_27,
    // In_Weight_28,
	// In_Weight_29,
	// In_Weight_30,
	// In_Weight_31,
	// In_Weight_32,
	out_valid,
	Out_OFM
);

//------------------------------
//	I/O Pors
//------------------------------
input       out_valid;
input [12:0]Out_OFM;

output reg rst_n;
output reg clk;
//output reg cg_en;
output reg in_valid;
//output reg weight_valid;

output reg [3:0]In_IFM_1;
output reg [3:0]In_IFM_2;
output reg [3:0]In_IFM_3;
output reg [3:0]In_IFM_4;
output reg [3:0]In_IFM_5;
output reg [3:0]In_IFM_6;
output reg [3:0]In_IFM_7;
output reg [3:0]In_IFM_8;
output reg [3:0]In_IFM_9;
output reg [3:0]In_IFM_10;
output reg [3:0]In_IFM_11;
output reg [3:0]In_IFM_12;
output reg [3:0]In_IFM_13;
output reg [3:0]In_IFM_14;
output reg [3:0]In_IFM_15;
output reg [3:0]In_IFM_16;
output reg [3:0]In_IFM_17;
output reg [3:0]In_IFM_18;
output reg [3:0]In_IFM_19;
output reg [3:0]In_IFM_20;
output reg [3:0]In_IFM_21;
output reg [3:0]In_IFM_22;
output reg [3:0]In_IFM_23;
output reg [3:0]In_IFM_24;
output reg [3:0]In_IFM_25;
output reg [3:0]In_IFM_26;
output reg [3:0]In_IFM_27;
output reg [3:0]In_IFM_28;
output reg [3:0]In_IFM_29;
output reg [3:0]In_IFM_30;
output reg [3:0]In_IFM_31;
output reg [3:0]In_IFM_32;	
// output reg [3:0]In_Weight_1;
// output reg [3:0]In_Weight_2;
// output reg [3:0]In_Weight_3;
// output reg [3:0]In_Weight_4;
// output reg [3:0]In_Weight_5;
// output reg [3:0]In_Weight_6;
// output reg [3:0]In_Weight_7;
// output reg [3:0]In_Weight_8;
// output reg [3:0]In_Weight_9;
// output reg [3:0]In_Weight_10;
// output reg [3:0]In_Weight_11;
// output reg [3:0]In_Weight_12;
// output reg [3:0]In_Weight_13;
// output reg [3:0]In_Weight_14;
// output reg [3:0]In_Weight_15;
// output reg [3:0]In_Weight_16;
// output reg [3:0]In_Weight_17;
// output reg [3:0]In_Weight_18;
// output reg [3:0]In_Weight_19;
// output reg [3:0]In_Weight_20;
// output reg [3:0]In_Weight_21;
// output reg [3:0]In_Weight_22;
// output reg [3:0]In_Weight_23;
// output reg [3:0]In_Weight_24;
// output reg [3:0]In_Weight_25;
// output reg [3:0]In_Weight_26;
// output reg [3:0]In_Weight_27;
// output reg [3:0]In_Weight_28;
// output reg [3:0]In_Weight_29;
// output reg [3:0]In_Weight_30;
// output reg [3:0]In_Weight_31;
// output reg [3:0]In_Weight_32;


//------------------------------
//	Parameter & Integer
//------------------------------
real	CYCLE = `clk_PERIOD;
//parameter Delay = 2.5;
parameter Pattern_num = 5;
//parameter Conv_size = 4;


integer seed = 2177;
integer j;
integer i;
integer pat;
integer ans_count;
//integer ans_row, ans_col;
integer output_num = 25;

//------------------------------
//	Register
//------------------------------
reg [3:0] Pattern_ifm [0:31][0:49];
reg [3:0] Pattern_weight[0:31];
reg [12:0] Pattern_ofm [0:49];


reg [12:0]Golden_OFM;
//reg [12:0] ans_array [0:49];
reg [12:0] result;
reg [5:0] out_count;

// reg [30:0]latency;
// reg [30:0]total_latency;

//------------------------------
//	Clock
//------------------------------
initial clk = 0;
always #(CYCLE/2) clk = ~clk;

//------------------------------
//	Initial
//------------------------------
initial begin
	reset_task;
	@(negedge clk)


    for(pat=0; pat<Pattern_num; pat=pat+1) begin
        repeat($urandom_range(3,2)) @(negedge clk);
        ans_count = 0;
        gen_ifm;
        for(i=0; i<50; i=i+1) begin
            @(negedge clk);
            #(CYCLE/2 + CYCLE/4)
            
            // if(i==0) begin
            //     weight_valid = 1;
            //     In_Weight_1 = Pattern_weight[0];
			// 	In_Weight_2 = Pattern_weight[1];
			// 	In_Weight_3 = Pattern_weight[2];
			// 	In_Weight_4 = Pattern_weight[3];
			// 	In_Weight_5 = Pattern_weight[4];
			// 	In_Weight_6 = Pattern_weight[5];
			// 	In_Weight_7 = Pattern_weight[6];
			// 	In_Weight_8 = Pattern_weight[7];
			// 	In_Weight_9 = Pattern_weight[8];
			// 	In_Weight_10 = Pattern_weight[9];
			// 	In_Weight_11 = Pattern_weight[10];
			// 	In_Weight_12 = Pattern_weight[11];
			// 	In_Weight_13 = Pattern_weight[12];
			// 	In_Weight_14 = Pattern_weight[13];
			// 	In_Weight_15 = Pattern_weight[14];
			// 	In_Weight_16 = Pattern_weight[15];
			// 	In_Weight_17 = Pattern_weight[16];
			// 	In_Weight_18 = Pattern_weight[17];
			// 	In_Weight_19 = Pattern_weight[18];
			// 	In_Weight_20 = Pattern_weight[19];
			// 	In_Weight_21 = Pattern_weight[20];
			// 	In_Weight_22 = Pattern_weight[21];
			// 	In_Weight_23 = Pattern_weight[22];
			// 	In_Weight_24 = Pattern_weight[23];
			// 	In_Weight_25 = Pattern_weight[24];
			// 	In_Weight_26 = Pattern_weight[25];
			// 	In_Weight_27 = Pattern_weight[26];
			// 	In_Weight_28 = Pattern_weight[27];
			// 	In_Weight_29 = Pattern_weight[28];
			// 	In_Weight_30 = Pattern_weight[29];
			// 	In_Weight_31 = Pattern_weight[30];
			// 	In_Weight_32 = Pattern_weight[31];
            // end
            // else begin
            //     weight_valid = 0;
            //     In_Weight_1 = 'dx;
			// 	In_Weight_2 = 'dx;
			// 	In_Weight_3 = 'dx;
			// 	In_Weight_4 = 'dx;
			// 	In_Weight_5 = 'dx;
			// 	In_Weight_6 = 'dx;
			// 	In_Weight_7 = 'dx;
			// 	In_Weight_8 = 'dx;
			// 	In_Weight_9 = 'dx;
			// 	In_Weight_10 = 'dx;
			// 	In_Weight_11 = 'dx;
			// 	In_Weight_12 = 'dx;
			// 	In_Weight_13 = 'dx;
			// 	In_Weight_14 = 'dx;
			// 	In_Weight_15 = 'dx;
			// 	In_Weight_16 = 'dx;
			// 	In_Weight_17 = 'dx;
			// 	In_Weight_18 = 'dx;
			// 	In_Weight_19 = 'dx;
			// 	In_Weight_20 = 'dx;
			// 	In_Weight_21 = 'dx;
			// 	In_Weight_22 = 'dx;
			// 	In_Weight_23 = 'dx;
			// 	In_Weight_24 = 'dx;
			// 	In_Weight_25 = 'dx;
			// 	In_Weight_26 = 'dx;
			// 	In_Weight_27 = 'dx;
			// 	In_Weight_28 = 'dx;
			// 	In_Weight_29 = 'dx;
			// 	In_Weight_30 = 'dx;
			// 	In_Weight_31 = 'dx;
			// 	In_Weight_32 = 'dx;
            // end
			in_valid = 1;
			In_IFM_1 = Pattern_ifm[0][i];
			In_IFM_2 = Pattern_ifm[1][i];
			In_IFM_3 = Pattern_ifm[2][i];
			In_IFM_4 = Pattern_ifm[3][i];
			In_IFM_5 = Pattern_ifm[4][i];
			In_IFM_6 = Pattern_ifm[5][i];
			In_IFM_7 = Pattern_ifm[6][i];
			In_IFM_8 = Pattern_ifm[7][i];
			In_IFM_9 = Pattern_ifm[8][i];
			In_IFM_10 = Pattern_ifm[9][i];
			In_IFM_11 = Pattern_ifm[10][i];
			In_IFM_12 = Pattern_ifm[11][i];
			In_IFM_13 = Pattern_ifm[12][i];
			In_IFM_14 = Pattern_ifm[13][i];
			In_IFM_15 = Pattern_ifm[14][i];
			In_IFM_16 = Pattern_ifm[15][i];
			In_IFM_17 = Pattern_ifm[16][i];
			In_IFM_18 = Pattern_ifm[17][i];
			In_IFM_19 = Pattern_ifm[18][i];
			In_IFM_20 = Pattern_ifm[19][i];
			In_IFM_21 = Pattern_ifm[20][i];
			In_IFM_22 = Pattern_ifm[21][i];
			In_IFM_23 = Pattern_ifm[22][i];
			In_IFM_24 = Pattern_ifm[23][i];
			In_IFM_25 = Pattern_ifm[24][i];
			In_IFM_26 = Pattern_ifm[25][i];
			In_IFM_27 = Pattern_ifm[26][i];
			In_IFM_28 = Pattern_ifm[27][i];
			In_IFM_29 = Pattern_ifm[28][i];
			In_IFM_30 = Pattern_ifm[29][i];
			In_IFM_31 = Pattern_ifm[30][i];
			In_IFM_32 = Pattern_ifm[31][i];						
        end
        //@(negedge clk);
        #(CYCLE)
        
        in_valid = 0;
        //weight_valid = 0;
        In_IFM_1 = 'd0;
		In_IFM_2 = 'd0;
		In_IFM_3 = 'd0;
		In_IFM_4 = 'd0;
		In_IFM_5 = 'd0;
		In_IFM_6 = 'd0;
		In_IFM_7 = 'd0;
		In_IFM_8 = 'd0;
		In_IFM_9 = 'd0;
		In_IFM_10 = 'd0;
		In_IFM_11 = 'd0;
		In_IFM_12 = 'd0;
		In_IFM_13 = 'd0;
		In_IFM_14 = 'd0;
		In_IFM_15 = 'd0;
		In_IFM_16 = 'd0;
		In_IFM_17 = 'd0;
		In_IFM_18 = 'd0;
		In_IFM_19 = 'd0;
		In_IFM_20 = 'd0;
		In_IFM_21 = 'd0;
		In_IFM_22 = 'd0;
		In_IFM_23 = 'd0;
		In_IFM_24 = 'd0;
		In_IFM_25 = 'd0;
		In_IFM_26 = 'd0;
		In_IFM_27 = 'd0;
		In_IFM_28 = 'd0;
		In_IFM_29 = 'd0;
		In_IFM_30 = 'd0;
		In_IFM_31 = 'd0;
		In_IFM_32 = 'd0;
        // In_Weight_1 = 'd0;
		// In_Weight_2 = 'd0;
		// In_Weight_3 = 'd0;
		// In_Weight_4 = 'd0;
		// In_Weight_5 = 'd0;
		// In_Weight_6 = 'd0;
		// In_Weight_7 = 'd0;
		// In_Weight_8 = 'd0;
		// In_Weight_9 = 'd0;
		// In_Weight_10 = 'd0;
		// In_Weight_11 = 'd0;
		// In_Weight_12 = 'd0;
		// In_Weight_13 = 'd0;
		// In_Weight_14 = 'd0;
		// In_Weight_15 = 'd0;
		// In_Weight_16 = 'd0;
		// In_Weight_17 = 'd0;
		// In_Weight_18 = 'd0;
		// In_Weight_19 = 'd0;
		// In_Weight_20 = 'd0;
		// In_Weight_21 = 'd0;
		// In_Weight_22 = 'd0;
		// In_Weight_23 = 'd0;
		// In_Weight_24 = 'd0;
		// In_Weight_25 = 'd0;
		// In_Weight_26 = 'd0;
		// In_Weight_27 = 'd0;
		// In_Weight_28 = 'd0;
		// In_Weight_29 = 'd0;
		// In_Weight_30 = 'd0;
		// In_Weight_31 = 'd0;
		// In_Weight_32 = 'd0;
        wait(ans_count == 49);
    end

    PASS;
end


task reset_task; begin
	force clk = 0;
	rst_n = 1;
	in_valid = 0;
	// weight_valid = 0;
	In_IFM_1 = 'd0;
   	In_IFM_2 = 'd0;
 	In_IFM_3 = 'd0;
	In_IFM_4 = 'd0;
 	In_IFM_5 = 'd0;
	In_IFM_6 = 'd0;
 	In_IFM_7 = 'd0;
 	In_IFM_8 = 'd0;
 	In_IFM_9 = 'd0;
 	In_IFM_10 = 'd0;
 	In_IFM_11 = 'd0;
 	In_IFM_12 = 'd0;
 	In_IFM_13 = 'd0;
 	In_IFM_14 = 'd0;
 	In_IFM_15 = 'd0;
 	In_IFM_16 = 'd0;
 	In_IFM_17 = 'd0;
 	In_IFM_18 = 'd0;
 	In_IFM_19 = 'd0;
 	In_IFM_20 = 'd0;
 	In_IFM_21 = 'd0;
 	In_IFM_22 = 'd0;
 	In_IFM_23 = 'd0;
 	In_IFM_24 = 'd0;
 	In_IFM_25 = 'd0;
 	In_IFM_26 = 'd0;
 	In_IFM_27 = 'd0;
 	In_IFM_28 = 'd0;
 	In_IFM_29 = 'd0;
 	In_IFM_30 = 'd0;
 	In_IFM_31 = 'd0;
 	In_IFM_32 = 'd0;
	// In_Weight_1 = 'd0;
	// In_Weight_2 = 'd0;
	// In_Weight_3 = 'd0;
	// In_Weight_4 = 'd0;
	// In_Weight_5 = 'd0;
	// In_Weight_6 = 'd0;
	// In_Weight_7 = 'd0;
	// In_Weight_8 = 'd0;
	// In_Weight_9 = 'd0;
	// In_Weight_10 = 'd0;
	// In_Weight_11 = 'd0;
	// In_Weight_12 = 'd0;
	// In_Weight_13 = 'd0;
	// In_Weight_14 = 'd0;
	// In_Weight_15 = 'd0;
	// In_Weight_16 = 'd0;
	// In_Weight_17 = 'd0;
	// In_Weight_18 = 'd0;
	// In_Weight_19 = 'd0;
	// In_Weight_20 = 'd0;
	// In_Weight_21 = 'd0;
	// In_Weight_22 = 'd0;
	// In_Weight_23 = 'd0;
	// In_Weight_24 = 'd0;
	// In_Weight_25 = 'd0;
	// In_Weight_26 = 'd0;
	// In_Weight_27 = 'd0;
	// In_Weight_28 = 'd0;
	// In_Weight_29 = 'd0;
	// In_Weight_30 = 'd0;
	// In_Weight_31 = 'd0;
	// In_Weight_32 = 'd0;
	
	#(CYCLE*10) rst_n = 0;
    #(CYCLE*10) rst_n = 1;
	
	if (Out_OFM!==0) begin
        $display("                                                                                                     ");
        $display("                                                                                                     ");
        $display("                                _ .___.-''.-=-.                                                      ");
        $display("                    __.-- _ _.-'_)_  (''`'-._\\ `.                                                   ");
        $display("                 _.'  __ |.' .-' __)  .-     /. |                                                    ");
        $display("               .'_.--'   |     -'  _)/         `\\                                                   ");
        $display("             .'.'      .'       .-'_.`           :                                                   ");
        $display("             .'     .-'       .(.-(              :                                                   ");
        $display("                  .'       .-' .    _            ;                                                   ");
        $display("                 /        .-._/`---'            /                                                    ");
        $display("                /        (____)(----. )       .'                                                     ");
        $display("               /         (      `.__.     / \\ /.           Output signals should be 0               ");
        $display("              :           ;-.___         /__ \\/|                                                    ");
        $display("              |         .'      `--.      -. \\ |           after the reset singal is asserted ......");
        $display("              :        /            \\    .__/                                                       ");
        $display("               \\      (__            \\    |_               at %4d ps                               ", $time*1000);
        $display("                \\       .`-. *       /   _|.\                                                       ");
        $display("                 \\    .'   `-.     .'_.-'   \\                                                      ");
        $display("                (_\\.-'    .'\')--.'-'       __\\                                                    ");
        $display("                 \\       /  // .'|      .--'  `-.                                                   ");
        $display("                  `-.    `-/ \\'  |   _.'         `.                                                 ");
        $display("                     `-._ /      `--'/             \\                                                ");
        $display("                        .'           |              \\                                               ");
        $display("                       /             |               \\                                              ");
        $display("                    .-'              |               /                                               ");
        $display("                   /                 |             -'                                                ");
        $display("                                                                                                     ");
        $display("                                                                                                     ");
        //$fclose(file);
        repeat(5) #(CYCLE);
        $finish;
    end

    #(CYCLE/2.0) release clk;
end
endtask

initial begin
	#(`clk_PERIOD * `End_CYCLE);
	$display("-----------------------------------------------------");
	$display("Error!!! Somethings' wrong with your code ...!!");
	$display("-------------------------FAIL------------------------");
	$display("-----------------------------------------------------");
	$finish;
end

always@(negedge clk) begin
	if(out_valid) begin
		Golden_OFM = Pattern_ofm[ans_count];
		if(Golden_OFM !== Out_OFM) begin
			//$display("Your: %d, Golden: %d", Out_OFM, Golden_OFM);
			fail;
		end
		ans_count = ans_count + 1;
	end
end

always@(negedge out_valid) begin
	if(ans_count != 50) begin
		$display("-----------------------------------------------------");
		$display("Error!!! out_valid cycle is less than 31...!!");
		$display("-------------------------FAIL------------------------");
		$display("-----------------------------------------------------");
		$finish;
	end
end


integer file_handle_1, file_handle_2, file_handle_3;
integer cnt_1, cnt_2, cnt_3;
// reg [4:0] imf_pattern [0:31][0:49];

initial begin 
// Open the file
file_handle_1 = $fopen("test_weight.txt", "r");
	// Check if the file is successfully opened
	if (file_handle_1 != 0) begin
		for (i = 0; i < 32; i = i + 1) begin
			cnt_1 = $fscanf(file_handle_1,"%d", Pattern_weight[i]);
			//$display(Pattern_weight[i]);
		end

		// Close the file
		$fclose(file_handle_1);
	end

file_handle_2 = $fopen("test_ifm.txt", "r");
	if (file_handle_2 != 0) begin
		for (j=0; j<32; j=j+1) begin
			for (i=0; i<50; i=i+1) begin
				cnt_2 = $fscanf(file_handle_2,"%d", Pattern_ifm[j][i]);
				//$display(Pattern_ifm[j][i]);
			end
		end

		$fclose(file_handle_2);
	end

	file_handle_3 = $fopen("test_answer.txt", "r");
	if (file_handle_3 != 0) begin
		for (i=0; i<50; i=i+1) begin
			cnt_3 = $fscanf(file_handle_3,"%d", Pattern_ofm[i]);
			// $display(Pattern_ofm[i]);
		end

		$fclose(file_handle_3);
	end

end


task gen_ifm; begin
    // for (i=0; i<32; i=i+1) begin
	// 	for(j=0; j<50; j=j+1) 
	// 		Pattern_ifm[i][j] = $random(seed);
	// end
	// Pattern_weight[0] = $random(seed);
	// Pattern_weight[1] = $random(seed);
	// Pattern_weight[2] = $random(seed);
	// Pattern_weight[3] = $random(seed);
	// Pattern_weight[4] = $random(seed);
	// Pattern_weight[5] = $random(seed);
	// Pattern_weight[6] = $random(seed);
	// Pattern_weight[7] = $random(seed);
	// Pattern_weight[8] = $random(seed);
	// Pattern_weight[9] = $random(seed);
	// Pattern_weight[10] = $random(seed);
	// Pattern_weight[11] = $random(seed);
	// Pattern_weight[12] = $random(seed);
	// Pattern_weight[13] = $random(seed);
	// Pattern_weight[14] = $random(seed);
	// Pattern_weight[15] = $random(seed);
	// Pattern_weight[16] = $random(seed);
	// Pattern_weight[17] = $random(seed);
	// Pattern_weight[18] = $random(seed);
	// Pattern_weight[19] = $random(seed);
	// Pattern_weight[20] = $random(seed);
	// Pattern_weight[21] = $random(seed);
	// Pattern_weight[22] = $random(seed);
	// Pattern_weight[23] = $random(seed);
	// Pattern_weight[24] = $random(seed);
	// Pattern_weight[25] = $random(seed);
	// Pattern_weight[26] = $random(seed);
	// Pattern_weight[27] = $random(seed);
	// Pattern_weight[28] = $random(seed);
	// Pattern_weight[29] = $random(seed);
	// Pattern_weight[30] = $random(seed);
	// Pattern_weight[31] = $random(seed);

	@(negedge clk);
	// for(i=0; i<50; i=i+1) begin
   
        // Pattern_ofm[i] = Pattern_ifm[0][i]*Pattern_weight[0]
        //                 + Pattern_ifm[1][i]*Pattern_weight[1]
		// 				+ Pattern_ifm[2][i]*Pattern_weight[2]
		// 				+ Pattern_ifm[3][i]*Pattern_weight[3]
		// 				+ Pattern_ifm[4][i]*Pattern_weight[4]
		// 				+ Pattern_ifm[5][i]*Pattern_weight[5]
		// 				+ Pattern_ifm[6][i]*Pattern_weight[6]
		// 				+ Pattern_ifm[7][i]*Pattern_weight[7]
		// 				+ Pattern_ifm[8][i]*Pattern_weight[8]
		// 				+ Pattern_ifm[9][i]*Pattern_weight[9]
		// 				+ Pattern_ifm[10][i]*Pattern_weight[10]
		// 				+ Pattern_ifm[11][i]*Pattern_weight[11]
		// 				+ Pattern_ifm[12][i]*Pattern_weight[12]
		// 				+ Pattern_ifm[13][i]*Pattern_weight[13]
		// 				+ Pattern_ifm[14][i]*Pattern_weight[14]
		// 				+ Pattern_ifm[15][i]*Pattern_weight[15]
		// 				+ Pattern_ifm[16][i]*Pattern_weight[16]
		// 				+ Pattern_ifm[17][i]*Pattern_weight[17]
		// 				+ Pattern_ifm[18][i]*Pattern_weight[18]
		// 				+ Pattern_ifm[19][i]*Pattern_weight[19]
		// 				+ Pattern_ifm[20][i]*Pattern_weight[20]
		// 				+ Pattern_ifm[21][i]*Pattern_weight[21]
		// 				+ Pattern_ifm[22][i]*Pattern_weight[22]
		// 				+ Pattern_ifm[23][i]*Pattern_weight[23]
		// 				+ Pattern_ifm[24][i]*Pattern_weight[24]
		// 				+ Pattern_ifm[25][i]*Pattern_weight[25]
		// 				+ Pattern_ifm[26][i]*Pattern_weight[26]
		// 				+ Pattern_ifm[27][i]*Pattern_weight[27]
		// 				+ Pattern_ifm[28][i]*Pattern_weight[28]
		// 				+ Pattern_ifm[29][i]*Pattern_weight[29]
		// 				+ Pattern_ifm[30][i]*Pattern_weight[30]
		// 				+ Pattern_ifm[31][i]*Pattern_weight[31];		  
		
	// end
	//@(negedge clk);
end
endtask

task PASS;begin
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8OOOOOOO8@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O               .o8@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:.                   .o@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o                         :O@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                           .o8@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@888888@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88888888OOO88@@@@@@@@@@                             :@@@@@@@");
$display("@@@@@@@@@@@@8o:.          .o8@@@@@@@@@@@@@@@@@@@88Oo:.                      .:ooo                              o@@@@@@");
$display("@@@@@@@@@@8                  .8@@@@@@@@@@@@8O:.           ..::::::ooo:.                                        .8@@@@@");
$display("@@@@@@@O.                      8@@@@@8O:.        .:O88@@@@@@@@@@@@@@@@@@@@@@@88Oo.                             :8@@@@@");
$display("@@@@@@o                        :8@@8.      .:o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@OO:                         o@@@@@@");
$display("@@@@@8                          :o.     .O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88@@8o.                      8@@@@@@");
$display("@@@@:                               o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:          :OO.                  o@@@@@8@");
$display("@@@o.                             :O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.              OO:              :8@@@@@@@@");
$display("@@8.                           O8@@@@@@@@@@O:.    .oO@@@@@@@@@@@@@@@@@@@@@@@.                o88          O@@@@@@@@@@@");
$display("@@O.                         :O@@@@@@@@@@:           o@@@@@@@@@@@@@@@@@@@@@@.                 .88o.     oO@@@@@@@@@@@@");
$display("@@O.                       :8@@@@@@@@@@8:            .O@@@@@@@@@@@@@@@@@@@@@o                  .@@8O:   o8@@@@@8@@@@@@");
$display("@@@:                      8@@@@@@@@@@O.               :8@@@@@@@@@@@@@@@@@@@@8o                  O@@@@.    8@@@@@@@@@8@");
$display("@@@@o                    :@@@@@@@@@@o                 :8@@@@@@@@@@@@@@@@@@@@@@o                 O@@@@O:   .O@@@@@@@@@@");
$display("@@@@@@.                .O@@@@@@@@@@8                  O@@@@@@@@@@@@@@@@@@@@@@@@@O             .O@@@@@@@@o   :@@@@@@@@@");
$display("@@@@@@@O:.           .O@@@@@@@@@@@@o                 .8@@@@@@@@@@@@888O8@@@@@@@@@o.         .o8@@@@@@@@@@o   o8@@@@@@@");
$display("@@@@@@@@@@8.         o@@@@@@@@@@@@@:                 o@@@@@@@O:.         :O@@@@@@@@Oo.   .:8@@@@@@@@@@@@@8     @@@@@@@");
$display("@@@@@@@@@@@@@@@@:    8@@@@@@@@@@@@@8               :8@@@@8:              .O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     @@@@@@");
$display("@@@@@@@@@@@@@@@@    :@@@@@@@@@@@@@@@O.             8@@@@@8:              o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8@@@    @@@@@@");
$display("@@@@@@@@@@@@@@@O   :@@@@@@@@@@@@@@@@@@@8O:....:O8@@@@@@@@@@@o          O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8@@@@    @@@@@");
$display("@@@@@@@@@@@@@@8:  :O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Oo.    .o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    @@@@");
$display("@@@@@@@@@@@@@8:   o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8  :@@@@@@@@@@@@@@@@@@@@@@@8Ooo\033[0;40;31m:::::\033[0;40;37moOO8@@8OOo   o@@@");
$display("@@@@@@@@@@@@@O   O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8. .8@@8o:O@@@@@@@@@@@@@8O\033[0;40;31m:::::::::::::::\033[0;40;37mO@@@O   :@@@");
$display("@@@@@@@@@@@@@O   O@@@@@@@@@@@@@@@@@@88888@@@@@@@@@@@@@@@@@@O:oO8@8.  .:    o@@@@@@@@@@@@O\033[0;40;31m::::::::::::::::::\033[0;40;37mo8@O   :8@@");
$display("@@@@@@@@@@@@@O   O@@@@@@@@@@@@@\033[1;40;31mO\033[0;40;31m:::::::::::::\033[0;40;37mo8@@@@@@@@@@@@8.              :@@@@@@@@@@8o\033[0;40;31m::::::::::::::::::::\033[0;40;37mo8@:   .@@");
$display("@@@@@@@@@@@@O.  .8@@@@@@@@@@8Oo\033[0;40;31m.:::::::::::::::\033[0;40;37moO@@@@@@@@@@8:              .@@@@@@@@@@O\033[0;40;31m::::::::::::::::::::::\033[0;40;37mo8O    @@");
$display("@@@@@@@@@@@@o   O@@@@@@@@@@8o\033[0;40;31m::::::::::::::::::::\033[0;40;37mo8@@@@@@@@@O              .@@@@@@@@@@O\033[0;40;31m::::::::::::::::::::::\033[0;40;37mo8O    @@");
$display("@@@@@@@@@@@@O.  :8@@@@@@@@o\033[0;40;31m::::::::::::::::::::::::\033[0;40;37m8@@@@@@@@@              :@@@@@@@@@@8o\033[0;40;31m:::::::::::::::::::::\033[0;40;37mO@o    @@");
$display("@@@@@@@@@@@@8:  :8@@@@@@@8\033[0;40;31m:::::::::::::::::::::::::\033[0;40;37m8@@@@@@@@@              O@@@@@@@@@@@O\033[0;40;31m::::::::::::::::::::\033[0;40;37mo8@:   :@@");
$display("@@@@@@@@@@@@@O   O@@@@@@8O\033[0;40;31m:::::::::::::::::::::::::\033[0;40;37mo8@@@@@@@@O           .8@@@@@@@@@@@@@8o\033[0;40;31m::::::::::::::::\033[0;40;37mo8@@@   .O@@");
$display("@@@@@@@@@@@@@O   O8@@@@@8O\033[0;40;31m:::::::::::::::::::::::::\033[0;40;37mo8@@@@@@@@@8:       .O@@@@@@@@@@@@@@@@@O\033[0;40;31m::::::::::::::\033[0;40;37mo@@@@8   .8@@");
$display("@@@@@@@@@@@@@O   O@@@@@@@O\033[0;40;31m::::::::::::::::::::::::.\033[0;40;37mO8@@@@8OOooo:.     :@@@@@@@@@@@@@@@@@@@@8OOo\033[0;40;31m::::::\033[0;40;37mooO8@@@@@o   :@@@");
$display("@@@@@@@@@@@@@8.  o8@@@@@@@\033[0;40;31m:::::::::::::::::::::::::\033[0;40;37m8@8O.                  .:O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8o   o@@@@");
$display("@@@@@@@@@@@@@8:  .O@@@@@@@O\033[0;40;31m:::::::::::::::::::::::\033[0;40;37mo@O.    .:oOOOo::.           .:OO8@@@@@@@@@@@@@@@@@@@@@@@@O.  :8@@@@");
$display("@@@@@@@@@@@@@@8.  :8@@@@@@@8o\033[0;40;31m:::::::::::::::::::\033[0;40;37mO8@O    8@@@@@@@@@@@@@@@@@8O..         :oO8@@@@@@@@@@@@@@@8o.  .8@@@@@");
$display("@@@@@@@@@@@@@@@O   :8@@@@@@@@8O\033[0;40;31m:::::::::::::::\033[0;40;37mO8@@@:   .@@@@@@@@@@@@@@@@@@@@@@88Oo:.       .:O8@@@@@@@@@@@.    O@@@@@@");
$display("@@@@@@@@@@@@@@@8    O@@@@@@@@@@8Oo\033[0;40;31m::::::::\033[0;40;37mooO8@@@@@O.   O@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:.      .o@@@@@@@@@o    O@@@@@@@");
$display("@@@@@@@@@@@@@@@@o    8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:    :O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o.    :O@@@8o.  .o@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@:    :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:      ...:oO8@@@@@@@@@@@@@@@@@@@@@@@@@O:   .O8.    .O@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@O:    :@@@@@@@@@@@@@@@@@@@@@@@@@@@O.   \033[0;40;33m...\033[0;40;37m          O@@@@@@@@@@@@@@@@@@@@@@@O       .O8@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@:    :O@@@@@@@@@@@@@@@@@@@@@@@@@O   \033[0;40;33m:O888Ooo:..\033[0;40;37m    :8@@@@@@@@@@@@@@@@@@@@O:     :O@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@8o     .O8@@@@@@@@@@@@@@@@@@@@@O:  \033[0;40;33m.o8888888888O.\033[0;40;37m  .O@@@@@@@@@@@OO888@8O:.    :O@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@O        o8@@@@@@@@@@@@@@@@@@@o   \033[0;40;33m:88888888888o\033[0;40;37m   o8@@@@@@@:              o8@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@:          .:88@@@@@@@@@@@@@8:   \033[0;40;33mo8888O88888O.\033[0;40;37m  .8@@@@@@@O    \033[1;40;33m..\033[0;40;37m     .::O@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@O.                  .:o          \033[0;40;33m8888\033[0;40;37m@@@@\033[0;40;33m888o.\033[0;40;37m  o8@@@@@8o   \033[0;40;33mo88o.\033[0;40;37m   @@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@o        .OOo:.                 \033[0;40;33mO88\033[0;40;37m@@@@@\033[0;40;33m888o.\033[0;40;37m  :8@@@@@o   \033[0;40;33m:O88.\033[0;40;37m   .@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@8o         :@@@@@O:             \033[0;40;33m.O8\033[0;40;37m@@@@\033[0;40;33m8888O:\033[0;40;37m   .O88O:   \033[0;40;33m.O88O\033[0;40;37m    O@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@:                             \033[0;40;33m.o8\033[0;40;37m@@@@\033[0;40;33m\033[0;40;33m888888O:\033[0;40;37m         \033[0;40;33m.888O:\033[0;40;37m   o8@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@8o                            \033[0;40;33m.O\033[0;40;37m@@@@\033[0;40;33m\888888888Oo:...ooO8888:   \033[0;40;37m:8@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8o                         \033[0;40;33mo8\033[0;40;37m@@@@\033[0;40;33m888888888888888888888O.\033[0;40;37m  :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o.                      \033[0;40;33m.8\033[0;40;37m@@@@\033[0;40;33m888888888888888888888O:\033[0;40;37m   o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O:.                 \033[0;40;33m.o8\033[0;40;37m@@@@@\033[0;40;33m88888888888888888888Oo\033[0;40;37m   :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8OOo::::::.   \033[0;40;33mo888\033[0;40;37m@@@@@\033[0;40;33m88888888888888888888o.\033[0;40;37m   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:   \033[0;40;33mo888\033[0;40;37m@@@@@\033[0;40;33m88888888888888888888.\033[0;40;37m   .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:   \033[0;40;33mo888\033[0;40;37m@@@@@\033[0;40;33m88888888888888888888O\033[0;40;37m   .O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.   \033[0;40;33mO8888\033[0;40;37m@@@\033[0;40;33m88888888888888888888O.\033[0;40;37m   O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o    \033[0;40;33m8888888888888888888888888888o\033[0;40;37m   o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.    \033[0;40;33m. ..:oOO8888888888888888888o.\033[0;40;37m  .8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.           \033[0;40;33m..:oO8888888888888O.\033[0;40;37m  .O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8OO.             \033[0;40;33m.oOO88O.\033[0;40;37m   O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88:..          \033[0;40;33m...\033[0;40;37m    8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88Ooo:.          @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8OoOO@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display ("----------------------------------------------------------------------------------------------------------------------");
$display ("                                                  Congratulations!                						            ");
$display ("                                           You have passed all patterns!          						            ");
$display ("----------------------------------------------------------------------------------------------------------------------");
$finish;	
end endtask

task fail;begin
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8Oo::::ooOOO8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o:   ..::..       .:o88@@@@@@@@@@@8OOoo:::..::oooOO8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8.   :8@@@@@@@@@@@@Oo..                   ..:.:..      .:O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8.  .8@@@@@@@@@@@@@@@@@@@@@@88888888888@@@@@@@@@@@@@@@@@8.    :O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:. .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8.   :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O  O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8.   :o@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o  8@@@@@@@@@@@@@8@@@@@@@@8o::o8@@@@@8ooO88@@@@@@@@@@@@@@@@@@@@@@@@8:.  .:ooO8@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o  :@@@@@@@@@@O      :@@@O   ..  :O@@@:       :@@@@OoO8@@@@@@@@@@@@@@@@Oo...     ..:o@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  :8@@@@@@@@@:  .@@88@@@8:  o@@o  :@@@. 0@@@.  O@@@      .O8@@@@@@@@@@@@@@@@@@8OOo.    O8@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  o@@@@@@@@@@O.      :8@8:  o@@O. .@@8  000o  .8@@O  O8O:  .@@o .O@@@@@@@@@@@@@@@@@@@o.  .o@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@. :8@@@@@@@@@@@@@@@:  .o8:  o@@o. .@@O  ::  .O@@@O.  o0o.  :@@O. :8@8::8@@@@@@@@@@@@@@@8O  .:8@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  o8@@@@@@@@@@@OO@@8.  o@8   ''  .O@@o  O@:  :O@@:  ::   .8@@@O. .:   .8@@@@@@@@@@@@@@@@@@O   8@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@. .O@@@@@@@@@@O      .8@@@@Oo::oO@@@@O  8@8:  :@8  :@O. :O@@@@8:   .o@@@@@@@@@@@@@@@@@@@@@@o  :8@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:  8@@@@@@@@@@@@8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o:8@8:  :@@@@:  .O@@@@@@@@@@@@@@@@@@@@@@@@8:  o@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:  .8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@OoO@@@O  :8@@@@@@@@@@@@@@@@@@@@@@@@@@8o  8@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8.   o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88@@@@@@@@@@@@@@@@@@@8::@@@@@88@@@@@@@@@@@@@@@@@@@@@@@  :8@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.  .:8@@@@@@@@@@@@@@@@@@@88OOoo::....:O88@@@@@@@@@@@@@@@@@@@@8o .8@@@@@@@@@@@@@@@@@@@@@@:  o@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o.   ..:o8888888OO::.      ....:o:..     oO@@@@@@@@@@@@@@@@8O..@@ooO@@@@@@@@@@@@@@@@@@O. :@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Oo::.          ..:OO@@@@@@@@@@@@@@@@O:  .o@@@@@@@@@@@@@@@@@@@O   8@@@@@@@@@@@@@@@@@. .O@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8O   .8@@@@@@@@@@@@@@@@@@@@@O  O@@@@@@@@@@@@@. o8@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O    .O@@@@@@@@@@@@@@@@@@8..8@@@@@@@@@@@@@. .O@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O:           ..:O88@888@@@@@@@@@@@@@@@@@@@@@@@O  O@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o.                          ..:oO@@@@@@@@@@@@@@@o  @@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.                      .o@@8O::.    o8@@@@@@@@@@@O  8@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o                         :O@@@@@@@o.  :O8@@@@@@@@8  o8@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@88OO888@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8888OOOOO8@@8888@@@@@O.                          .@@@@@@@@@:.  :@@@@@@@@@. .O@");
$display("@@@@@@@@@@@@@@@@@@@@8o:           O8@@@@@@@@@@@@@@@@@@@8OO:.                     .::                            :8@@@@@@@@@.  .O@@@@@@@o. o@");
$display("@@@@@@@@@@@@@@@@@@.                 o8@@@@@@@@@@@O:.         .::oOOO8Oo:..::::..                                 o@@@@@@@@@@8:  8@@@@@@o. o@");
$display("@@@@@@@@@@@@@@@@:                    .@@@@@Oo.        .:OO@@@@@@@@@@@@@@@@@@@@@@@@@o.                            O@@@@@@@@@@@@  o8@@@@@O. o@");
$display("@@@@@@@@@@@@@@:                       o88.     ..O88@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@888O.                     .8@@@@@@@@@@@@  o8@@@@@: .O@");
$display("@@@@@@@@@@@@O:                             :o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:                  .8@@@@@@@@@@@8o  8@@@@@O  O@@");
$display("@@@@@@@@@@@O.                            :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o.              :8@@@@@@@@@@8.  .O@@@@o.  :@@@");
$display("@@@@@@@@@@@:                          :O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O:          .o@@@@@@@@@8o   .o@@@8:.  .@@@@@");
$display("@@@@@@@@@@@.                        O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.    .o8@@@@@@@@@@O  :O@@8o:   .O@@@@@@@");
$display("@@@@@@@@@@@.                      :O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O:   o8@@@@@@@@8           oO@@@@@@@@@@");
$display("@@@@@@@@@@@:                     o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.   .@@@@@@@O.      .:o8@@@@@@@@@@@@@");
$display("@@@@@@@@@@@8o                   8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o   :@@@@O     o8@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@8.               .O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:   .@@@8..:8@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@8:            .o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.  :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@8O.        8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   :@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@8o   o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@o   O@@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@O   O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O   :@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@8   :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:   8@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@8o  :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:..   .:o@@@@@@@@@@@@@@@@@@8.  O@@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@8o  :8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O.         .:@@@@@@@@@@@@@@@@@:  :O@@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@O.  o@@@@@@@@@@@@@@@@@@@@@@8OOO8@@@@@@@@@@@@@@@@@@@@@@@@@@@8.             .@@@@@@@@@@@@@@@@.  .O@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@o.  .@@@@@@@@@@@@@@@@@@@8:.       :8@@@@@@@@@@@@@@@@@@@@@@@@8.               o8@@@@@@@@@@@@@o. .:@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@o.  :@@@@@@@@@@@@@@@@@O            .@@@@@@@@@@@@@@@@@@@@@@@@@:                .8@@@@@@@@@@@@O.  :@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@O.  .@@@@@@@@@@@@@@@@:             .8@@@@@@@@@@@@@@@@@@@@@@@@O:                o@@@@@@@@@@@@O:  .@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@O.  .@@@@@@@@@@@@@@8:               8@@@@@@@@@@@@@@@@@@@@@@@@@@.               o@@@@@@@@@@@@O:  .@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@O.  .@@@@@@@@@@@@@o.                8@@@@@@@@@@@@@@@@@@@@@@@@@@8o             .8@@@@@@@@@@@@O.  .@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@8:  .@@@@@@@@@@@@@                 :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:.        O8@@@@@@@@@@@@@@o.  :@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@o   8@@@@@@@@@@@@.               :8@@@@@@@@@          :8@@@@@@@@@@@8OoooO@@@@@@@@@@@@@@@@@@.  .o@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@88O:   O@@@@@@@@@@@@O:             .@@@@@@@@O             .8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8   :8@@@@@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@O:.       :O8@@@@@@@@@@8o           :O@@@@@@@8:             :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8:       :o@@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@o              ..:8@@@@@@@@@8o:::.:O8@@@@@@@@@@@8.           :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O:.             o@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@8o                   :@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:.     .o@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8                  o8@@@@@@@@@@@@@@@");
$display("8OOOooooOOoo:.                    :OOOOOOOOOO8888OOOOOOOOOOOoo:ooOOOo: .OOOOOOOOOO888OOooOO888OOOOOooO8:                   .:OOOOOOOOOOO88@@");
$display("            .                                                                                                                               ");
$display("@@@@@@@@@@@@@@8o                 .8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8                    :8@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@8O.             o8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8o                 .@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@::.       :O@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@O..         .:8@@@@@@@@@@@@@@@@@@");
$display("@@@@@@@@@@@@@@@@@@@@@@@@@88O8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@88@@@@@@@@@@@@@@@@@@@@@@@@@@");
$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
$display ("                                                                        OUTPUT FAIL!                                                        ");
$display ("                                                           Ans(OUT): %d,  Your output : %4d  at %8t                           ",Golden_OFM,Out_OFM,$time);
$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
$finish;
end
endtask


endmodule
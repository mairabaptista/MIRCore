module InstructionMem(
	address, 
	clk, 
	instructionOut, 
	clk_auto, 
	write_flag, //adicionado, flag de escrita na memoria
	write_os, //adicionado, flag de escrita no so
	input_instr, //adicionado, instrucao de entrada, nao eh a do pc
	MODE, //adicionado, KERNEL MODE = 0 / USER MODE = 1
	read_address //adicionado, 
	);

	parameter DATA_WIDTH = 32;
	parameter PAGE_WIDTH = 10;
	
	//INPUTS
	input [(DATA_WIDTH - 1):0] address;
	input [(DATA_WIDTH - 1):0] read_address;
	input [(DATA_WIDTH - 1):0] input_instr;
	input clk, clk_auto, write_flag, write_os, MODE;
	
	//OUTPUTS
	output [(DATA_WIDTH - 1):0]instructionOut;
	
	reg [(DATA_WIDTH - 1):0] ROM_OS[2**(PAGE_WIDTH - 1):0];
	reg [(DATA_WIDTH - 1):0] ROM_PROC[2**(PAGE_WIDTH - 1):0];
	
	reg [(DATA_WIDTH - 1):0] data_out_os; 
	reg [(DATA_WIDTH - 1):0] data_out_proc;
	
		
	always @(posedge clk)
		begin
			if(write_flag)
				begin
					if (write_os)
						ROM_OS[read_address] <= input_instr;
					else
						ROM_PROC[read_address] <= input_instr;
				end			
		end
	
	always @(posedge clk_auto)
		begin
			data_out_os <= ROM_OS[address];
			data_out_proc <= ROM_PROC[address];
		end

	assign instructionOut = (MODE == 1'b0) ? data_out_os : data_out_proc;
	
endmodule

/*
ROM[0] <= 32'b01110000000000000000000000000000;	//nop
ROM[1] <= 32'b10010100000111100000000000000000;	//input reg30
ROM[2] <= 32'b11111100000111100000000000000000;	//output reg30
ROM[3] <= 32'b10000100000000000000000000000111;	//jal 7
ROM[4] <= 32'b11111100000111100000000000000000;	//output reg30
ROM[5] <= 32'b11111100000111110000000000000000;	//output reg31
ROM[6] <= 32'b01110100000000000000000000000000;	//hlt
ROM[7] <= 32'b00111100001000100000000000000001;	//li reg2 = 1
ROM[8] <= 32'b11111100000000100000000000000000;	//output reg2
ROM[9] <= 32'b01100111111000000000000000000000;  //jr to ROM[reg31]
ROM[10] <= 32'b01110100000000000000000000000000;	//hlt */
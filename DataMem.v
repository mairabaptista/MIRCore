module DataMem(writeDataIN, address, clk, memWrite, display, displayFlag, readDataOut, clk_auto, shift_amount);

	input [31:0] writeDataIN, address, shift_amount;
	input clk, clk_auto, memWrite, displayFlag; 
	output reg [31:0] readDataOut, display;
	
	reg [31:0] displayout;
	parameter addr = 13;
	reg [31:0] MEMORIA[((2**addr)-1):0];
	
	always @(negedge clk)
		begin 
			if(memWrite)
				MEMORIA[address + shift_amount] <= writeDataIN;
			if(displayFlag)
				displayout = writeDataIN;
		end	
	
	always @(negedge clk_auto)
	begin
		readDataOut <= MEMORIA[address + shift_amount];
		display <= displayout;
	end
	
endmodule 

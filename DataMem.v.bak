module DataMem(writeDataIN, address, clk, memWrite, display, displayFlag, readDataOut);

	input [31:0] writeDataIN, address;
	input clk, memWrite, displayFlag; 
	output [31:0] readDataOut, display;
	
	reg [31:0] displayout;
	
	reg [31:0]MEMORIA[31:0];
	
	always @(negedge clk)
		begin 
			if(memWrite)
				MEMORIA[address] = writeDataIN;
			if(displayFlag)
				displayout = writeDataIN;
		end	
	
	assign readDataOut = MEMORIA[address];
	assign display = displayout;
	
endmodule 

module DataMem(writeDataIN, address, clk, memWrite, display, displayFlag, readDataOut, clk_auto, shift_amount, UART_out, UARTC);
	//UART_out and tx_siganl variables and logic added for lsc-redes
	input [31:0] writeDataIN, address, shift_amount;
	input clk, clk_auto, memWrite, displayFlag; 
	input [2:0] UARTC;
	output reg [31:0] readDataOut, display, UART_out;
	
	reg [31:0] displayout, transmit_out;
	parameter addr = 13;
	reg [31:0] MEMORIA[((2**addr)-1):0];
	
	always @(negedge clk)
		begin 
			if(memWrite)
				MEMORIA[address + shift_amount] <= writeDataIN;
			if(displayFlag)
				displayout = writeDataIN;
			if(UARTC == 3'b100 || UARTC == 3'b011)
				transmit_out = writeDataIN;
		end	
	
	always @(negedge clk_auto)
	begin
		readDataOut <= MEMORIA[address + shift_amount];
		display <= displayout;
		UART_out <= transmit_out;
	end
	
endmodule 

module PROCESS_DECODE(process_in, process_decoded);
	
	//INPUTS
	input [31:0] process_in;
	
	//OUTPUTS
	output process_decoded;
	
	assign process_decoded = (process_in == 32'b0) ? 1'b0 : 1'b1;
	
endmodule

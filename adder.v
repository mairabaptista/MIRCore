module ADDER(next_addr, extended_imm, saida);

	input [31:0] next_addr, extended_imm;
	output [31:0] saida;
	
	assign saida = /*next_addr +*/ extended_imm;

endmodule

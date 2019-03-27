module SE_26_32(sinal_entrada, sinal_estendido);

	input [25:0] sinal_entrada;
	output reg [31:0] sinal_estendido;

	always @(*)
		begin
			sinal_estendido = $signed(sinal_entrada);
		end	

endmodule 
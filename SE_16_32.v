module SE_16_32(sinal_entrada, sinal_estendido);

	input [15:0] sinal_entrada;
	output reg [31:0] sinal_estendido;

	always @(*)
		begin
			/*if (sinal_entrada[15])
				sinal_estendido = {16'b1111111111111111, sinal_entrada};
			else
				sinal_estendido = {16'b0, sinal_entrada};*/
			sinal_estendido = $signed(sinal_entrada);
		end	

endmodule 
module MUX_INPUT(entrada1, entrada2, sinal, saida);

	input [31:0] entrada1, entrada2;
	input sinal;
	output reg [31:0] saida;
	
	always @(*)
		if(sinal == 1'b0)
			saida = entrada1;
		else
			saida = entrada2;			

endmodule 
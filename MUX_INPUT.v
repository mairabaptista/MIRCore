module MUX_INPUT(entrada1, entrada2, sinal, saida, UART_in, uartc);

	input [31:0] entrada1, entrada2, UART_in;
	input sinal;
	input [2:0] uartc;
	output reg [31:0] saida;
	
	always @(*) begin
		if(sinal == 1'b0 && uartc == 3'b000) begin
			saida = entrada1;
		end
		if(sinal == 1'b1 && uartc == 3'b000) begin
			saida = entrada2;	
		end
		if(sinal == 1'b0 && uartc == 3'b010) begin
			saida = UART_in;			
		end
	end
endmodule 
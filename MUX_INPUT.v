module MUX_INPUT(entrada1, entrada2, sinal, saida, UART_in, rx_signal);

	input [31:0] entrada1, entrada2, UART_in;
	input sinal, rx_signal;
	output reg [31:0] saida;
	
	always @(*) begin
		if(sinal == 1'b0 && rx_signal == 1'b0) begin
			saida = entrada1;
		end
		if(sinal == 1'b1 && rx_signal == 1'b0) begin
			saida = entrada2;	
		end
		if(sinal == 1'b0 && rx_signal == 1'b1) begin
			saida = UART_in;			
		end
	end
endmodule 
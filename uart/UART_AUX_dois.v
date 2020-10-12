module UART_AUX_dois (
	input [7:0] super_aux_read,
	input aux_signal_read,
	output reg [7:0] super_aux_saida_read
);

	always @(*)
		if(aux_signal_read == 1'b1)
			super_aux_saida_read = super_aux_read;
		else
			super_aux_saida_read = 8'b0;	

endmodule
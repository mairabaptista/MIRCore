module UARTDecoder (
	input rx_signal,
	input tx_signal,
	input baud_rate,
	output [2:0] UARTC
);

	reg [2:0] uartc_aux;

	always @(*) begin
		if (rx_signal) begin
			uartc_aux = 3'b010;
		end

		if (tx_signal) begin
			uartc_aux = 3'b011;
		end

		if (baud_rate) begin
			uartc_aux = 3'b100;
		end

		else begin
			uartc_aux = 3'b000;
		end
	end
	
	assign UARTC = uartc_aux;


endmodule

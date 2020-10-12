module UARTModule (
	input clock,
	input physical_clock,
	input init_flag,
	input UART_ENB,
	input [2:0] instruction,
	input [31:0] write_value,
	input rx,
	output tx,
	output wb_flag,
	output [7:0] wb_data,
	// para testes
	output custom_uart_clock_out,
	output [1:0] read_state_out,
	output [3:0] sample_count
	
);

wire custom_uart_clock, sampling_clock, sampled_rx;
assign custom_uart_clock_out = custom_uart_clock;

UARTController controller(.clock(clock),
									.physical_clock(physical_clock),
									.uart_clock(custom_uart_clock),
									.init_flag(init_flag),
									.UART_ENB(UART_ENB),
									.instruction(instruction),
									.write_value(write_value[7:0]),
									.rx(sampled_rx),
									.tx(tx),
									.wb_flag(wb_flag),
									.wb_data(wb_data),
									.read_state_out(read_state_out) 
									);
									
UARTClockGenerator clock_gen(	.physical_clock(physical_clock),
										.init_flag(init_flag),
										.instruction(instruction),
										.baudrate_value(write_value),
										.uart_clock(custom_uart_clock),
										.sampling_clock_out(sampling_clock) 
										);

RXSampler sampler( .sampling_clock(sampling_clock),
						 .init_flag(init_flag),
						 .rx(rx),
						 .sampled_rx(sampled_rx),
						 .counter_out(sample_count)
						 );


endmodule

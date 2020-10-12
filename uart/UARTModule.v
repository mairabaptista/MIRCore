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
	output [3:0] sample_count,
	output [7:0] super_aux,
	output aux_signal,
	output [7:0] super_aux_saida
	//output ready_to_send,
	//input ready_to_receive
	
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
									//.ready_to_receive(ready_to_receive),
									.tx(tx),
									//.ready_to_send(ready_to_send),
									.wb_flag(wb_flag),
									.wb_data(wb_data),
									.read_state_out(read_state_out),
									.super_aux(super_aux),
									.aux_signal(aux_signal)
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
						 
UART_AUX uart_aux(.super_aux(super_aux),
						.aux_signal(aux_signal),
						.super_aux_saida(super_aux_saida));


endmodule

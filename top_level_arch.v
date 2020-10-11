module top_level_arch(clock_A, clock_B, physical_clock, init_flag, instruction_A,  instruction_B, write_value_A, write_value_B,
								wb_flag_A, wb_data_A, wb_flag_B,  wb_data_B, rxA_to_txB_out, rxB_to_txA_out, uart_clock_A, uart_clock_B,
								read_state_B, sample_count_B, reset, switches, rdata2, outPC, display);

	input reset;
	input [15:0] switches;
	
	input clock_B, physical_clock, init_flag;
	output wire clock_A;
	
	input [2:0] instruction_B;	
	input [31:0]write_value_B;
	output wire [2:0] instruction_A;
	output wire [31:0] write_value_A;
	
	output wb_flag_A, wb_flag_B;
	output [7:0] wb_data_A, wb_data_B;
	
	output rxA_to_txB_out, rxB_to_txA_out, uart_clock_A, uart_clock_B;
	
	output [1:0] read_state_B;
	output [3:0] sample_count_B;
	
	wire rxA_to_txB, rxB_to_txA;
	assign rxA_to_txB_out = rxA_to_txB;
	assign rxB_to_txA_out = rxB_to_txA;
	
	output wire [31:0] rdata2, outPC, display;
	

	UARTModule Module_A(.clock(clock_A),
							  .physical_clock(physical_clock),
							  .init_flag(init_flag),
							  .UART_ENB(1'b1),
							  .instruction(instruction_A),
							  .write_value(write_value_A),
							  .rx(rxA_to_txB),
							  .tx(rxB_to_txA),
							  .wb_flag(wb_flag_A),
							  .wb_data(wb_data_A),
							  .custom_uart_clock_out(uart_clock_A)
								);
								
	core core_a(.clock50M(physical_clock), 
					.reset(reset), 
					.switches(switches),  
					.clock(clock_A), 
					.UART_in(wb_data_A), 
					.UART_out(write_value_A),
					.wb_flag(wb_flag_A),
					.UARTC(instruction_A),
					.rdata2(rdata2), 
					.outPC(outPC), 
					.display(display));
								
	UARTModule Module_B(.clock(clock_B),
							  .physical_clock(physical_clock),
							  .init_flag(init_flag),
							  .UART_ENB(1'b1),
							  .instruction(instruction_B),
							  .write_value(write_value_B),
							  .rx(rxB_to_txA),
							  .tx(rxA_to_txB),
							  .wb_flag(wb_flag_B),
							  .wb_data(wb_data_B),
							  .custom_uart_clock_out(uart_clock_B),
							  .read_state_out(read_state_B),
							  .sample_count(sample_count_B)
								);
		
endmodule 
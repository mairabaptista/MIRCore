module MUX_BIOS(mux_select, clk, rst, input_data_1, input_data_2, mux_output, state);

	parameter DATA_WIDTH = 32;
	input mux_select, clk;
	input [(DATA_WIDTH-1):0] input_data_1, input_data_2;
	output [(DATA_WIDTH-1):0] mux_output;	
	output reg rst;
	output reg state;
	
	localparam BIOS = 1'b0, MEMORY = 1'b1;
	localparam HALT = 6'b011101;
	
	initial begin
		state <= BIOS;
	end

	always @ ( posedge clk ) 	
	begin		
			if (state == BIOS)
				begin
					case(input_data_1[31:26])
						HALT: 
							begin
								state <= MEMORY;
								rst <= 1'b1;
							end
					default:	
						begin
							rst <= 1'b0;
						end
					endcase
				end
			else
				begin
					rst <= 1'b0;
				end		
	end
	
	assign mux_output = (state == BIOS) ? input_data_1 : input_data_2;
	
endmodule

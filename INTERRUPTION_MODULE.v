module INTERRUPTION_MODULE (clk, opcode, intrpt);

	parameter QUANTUM = 10; //low values to show up on waveform
	parameter DEFAULT_WIDTH = 6;
	parameter TIMER_WIDTH = 5;
	parameter OFFSET_WIDTH = 16 ;
	
	//input [(DEFAULT_WIDTH -1):0] offset,
	input clk;
	input [(DEFAULT_WIDTH-1):0] opcode;
	//output reg [(DEFAULT_WIDTH -1):0] intrpt_val; 
	output reg intrpt;

	reg [(TIMER_WIDTH -1):0] timer;

	always @ ( posedge clk )
	begin
		case( opcode )
			6'b100101: //input
			begin
				timer = 1'b0;
				intrpt = 1'b1;
				//intrpt_val = 1'b1;
			end
			6'b111111: //output
			begin
				timer = 1'b0;
				intrpt = 1'b1;
				//intrpt_val = 1'b1;
				//intrpt = ( proc_num == 1'b0 ) ? 1'b0 : 1'b1;
				//intrpt_val = ( proc_num == 1'b0 ) ? 6'b000000 : 6'b000100;
			end
			default:
			begin
				timer = ( timer == QUANTUM ) ? 1'b0 : timer + 1'b1; //quantum counter, resets when reaches a certain quantum
				intrpt = 1'b0;
				//intrpt = ( timer == QUANTUM ) ? ( proc_num == 1'b0 ) ? 1'b0 : 1'b1 : 1'b0;
				//intrpt_val = ( timer == QUANTUM ) ? ( proc_num == 1'b0 ) ? 6'b000000 : 6'b000001 : 6'b000000;
			end
		endcase
	end
	
endmodule 
module INTERRUPTION_MODULE (clock, opcode, intrpt, intrpt_val);

	parameter DATA_WIDTH = 32;
	
	input clock;
	input [5:0] opcode;
	output reg [(DATA_WIDTH -1):0] intrpt_val; 
	output reg intrpt;

	always @ ( posedge clock )
	begin
		case( opcode )
			6'b111010: //input
			begin
				intrpt = 1'b1;
				intrpt_val <= 32'b00000000000000000000000000000001;
			end
			6'b111011: //output
			begin
				intrpt = 1'b1;	
				intrpt_val <= 32'b00000000000000000000000000000010;
			end
			6'b111100: //program end
			begin
				intrpt = 1'b1;	
				intrpt_val <= 32'b00000000000000000000000000000011;
			end
			default:
			begin
				intrpt = 1'b0;
				intrpt_val <= 32'b0;
			end
		endcase
	end
	
endmodule 
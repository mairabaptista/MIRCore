module Temporizador(clock, clockT);
	input clock;
	output reg clockT;
	reg [19:0] count;
	always @(posedge clock)
		begin
			if (count == 20'b10111110101111000010)
				begin
					clockT <= ~clockT;
					count  <= 20'b00000000000000000000;
				end
			else
				begin
					count <= count + 1;
				end
		end
		
endmodule 
module pc(clk, reset, hlt, address, newAddress, outPC);
	input clk, hlt, reset;
	input [9:0]address;
	output reg [9:0]newAddress;
	output wire[9:0]outPC;
	wire [3:0] unidade, dezena;
	reg [9:0] aux;
	
	always @(*)
		begin
			aux = address;
		end
	
	always @(posedge clk)
		begin
			if (reset)
				begin
					newAddress = 10'b0;
				end						
			
			else if(hlt)
				begin
				end
			
			else
				newAddress = aux;
		end
		
	assign outPC = newAddress;
endmodule

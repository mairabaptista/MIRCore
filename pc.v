module pc(clk, reset, hlt, address, outPC, bios_reset);
	input clk, hlt, reset, bios_reset;
	input [9:0]address;
	reg [9:0]newAddress;
	output [9:0]outPC;

	
	always @(posedge clk)
		begin
			if (reset)
				begin
					newAddress <= 10'b0;
				end						
			
			else if(hlt)
				begin
				end
			else
				newAddress <= address;	
			
			if(bios_reset)
				begin
					newAddress <= 10'b0;
				end
			
		end
		
	assign outPC = newAddress;
endmodule


/*
module pc(clk, reset, hlt, address, newAddress, outPC, bios_reset);
	input clk, hlt, reset, bios_reset;
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
				
			else if(bios_reset)
				begin
					newAddress = 10'b0;
				end
			else
				newAddress = aux;
		end
		
	assign outPC = newAddress;
endmodule

*/
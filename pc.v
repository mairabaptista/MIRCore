module pc(clk, reset, hlt, address, outPC, bios_reset, proc_num, only_proc_pc);

	//INPUTS
	input clk, hlt, reset, bios_reset, proc_num;
	input [9:0]address;	
	
	//OUTPUTS
	output [9:0] outPC; //prog_count
	output [9:0] only_proc_pc;
	
	
	reg [9:0] newAddress;
	reg [9:0] pc_os;
	reg [9:0] pc_proc;
	
	always @(posedge clk)
		begin
			if(proc_num == 1'b0) //OS pc
			begin
				if (reset)
					begin
						pc_os <= 10'b0;
					end			
				else if(hlt)
					begin
					end
				else
					pc_os <= address;	
			
				if(bios_reset)
					begin
						pc_os <= 10'b0;
					end
			end
			
			else //process pc
			begin
				if (reset)
					begin
						pc_proc <= 10'b0;
					end			
				else if(hlt)
					begin
					end
				else
					pc_proc <= address;	
			
				if(bios_reset)
					begin
						pc_proc <= 10'b0;
					end
			end
			
			
		end
	assign outPC = (proc_num == 1'b1) ? pc_proc : pc_os;	
	assign only_proc_pc = pc_proc;
	//assign outPC = newAddress;
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
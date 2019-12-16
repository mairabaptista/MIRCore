module PROCESS_KEEPER(proc_swap, clock, intrpt, new_proc_num, exec_proc);
	
	//INPUTS
	input proc_swap, clock, intrpt;
	input [31:0] new_proc_num;	
	
	//OUTPUTS
	output [31:0] exec_proc;
	
	reg [31:0] proc_num;
	
	always @ (posedge clock)
	begin
		if(intrpt) 
			proc_num <= 32'b0;
		else if(proc_swap)
			proc_num <= new_proc_num;
	end

	assign exec_proc = proc_num;
	
endmodule

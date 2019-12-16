module MEM_SHIFTER(proc_index, shift_amount);

//inputs
input [31:0] proc_index;

//output
output [31:0] shift_amount;

reg [31:0] shift_reg;

parameter SHIFT = 512;

always @ (*) begin
	shift_reg <= proc_index * SHIFT;
end

assign shift_amount = shift_reg;

endmodule 
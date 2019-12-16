module ADDRESS_SET(chng_wrt_shft, chng_rd_shft, clock, wrt_shft_enabler, rd_shft_enabler);

	//INPUTS
	input chng_wrt_shft, chng_rd_shft, clock;
	
	//OUTPUTS
	output wrt_shft_enabler, rd_shft_enabler;
	
	reg rd_shft, wrt_shft;
	
	always @ (posedge clock)
	begin
		if((chng_wrt_shft == 1'b1) && (wrt_shft == 1'b0))
			wrt_shft <= 1'b1;
		else if((chng_wrt_shft == 1'b1) && (wrt_shft == 1'b1))
			wrt_shft <= 1'b0;
		if((chng_rd_shft == 1'b1) && (rd_shft == 1'b0))
			rd_shft <= 1'b1;
		else if((chng_rd_shft == 1'b1) && (rd_shft == 1'b1))
			rd_shft <= 1'b0;
	end
	
	assign wrt_shft_enabler = wrt_shft;
	assign rd_shft_enabler = rd_shft;
	
endmodule

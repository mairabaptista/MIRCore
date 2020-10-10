module maquinaEstadosUART( clk, wb_flag, saida );

	input clk, wb_flag;
	output reg saida;
	reg state = 0;
	
	always @( posedge clk )
	begin
		if( state == 0 )
		begin
			saida = wb_flag;
			if( wb_flag == 0 )
				state = 1;
		end
		else
		begin
			saida = 1;
			if( wb_flag == 1 )
				state = 0;
		end
	end

endmodule
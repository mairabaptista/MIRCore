module BancoREG(readRegister1, readRegister2, writeRegister, writeData, readData1, readData2, clk, regWrite, PC, jal,
					rd_shft_enabler, wrt_shft_enabler, intrpt_val, intrpt, proc_pc, save_proc_pc);
    
	 parameter DATA_WIDTH = 32;
	 
	 //INPUTS
	 input clk, regWrite, jal, rd_shft_enabler, wrt_shft_enabler, save_proc_pc;
    input [4:0] readRegister1;
	 input [4:0] readRegister2; 
	 input [4:0] writeRegister; //RD
    input [(DATA_WIDTH-1):0] writeData;
	 input [(DATA_WIDTH-1):0] PC;
	 input [(DATA_WIDTH-1):0] intrpt_val;
	 input [(DATA_WIDTH-1):0] proc_pc;
	 input intrpt;
	 
	 //OUTPUTS
    output [(DATA_WIDTH-1):0] readData1; //RS
	 output [(DATA_WIDTH-1):0] readData2; //RT
    reg [(DATA_WIDTH-1):0]registradores[(2*DATA_WIDTH-1):0];

    always @ (posedge clk)
        begin
				registradores[0] <= 32'b0;
				if(jal == 1)
					begin
						registradores[31] <= PC + 1;
					end
            if (regWrite == 1)
                begin
						registradores[writeRegister + (DATA_WIDTH*wrt_shft_enabler)] <= writeData;						  
                end
				if(intrpt)
				begin
					registradores[5'b00010] <= intrpt_val; //$v1
				end
				if(save_proc_pc)
				begin
					registradores[5'b00010] <= proc_pc;  //$v1
				end
        end
	    
    assign readData1 = registradores[readRegister1 + (DATA_WIDTH*rd_shft_enabler)];
    assign readData2 = registradores[readRegister2 + (DATA_WIDTH*rd_shft_enabler)];

endmodule	
			

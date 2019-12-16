module BancoREG(readRegister1, readRegister2, writeRegister, writeData, readData1, readData2, clk, regWrite, PC, jal);
    
	parameter DATA_WIDTH = 32;
	 
	 //INPUTS
	 input clk, regWrite, jal;
    input [4:0] readRegister1;
	 input [4:0] readRegister2; 
	 input [4:0] writeRegister; //RD
    input [(DATA_WIDTH-1):0] writeData;
	 input [(DATA_WIDTH-1):0] PC;
	 
	 //OUTPUTS
    output [(DATA_WIDTH-1):0] readData1; //RS
	 output [(DATA_WIDTH-1):0] readData2; //RT
    reg [(DATA_WIDTH-1):0]registradores[(DATA_WIDTH-1):0];

    always @ (posedge clk)
        begin
				registradores[0] <= 32'b0;
				if(jal == 1)
					begin
						registradores[31] <= PC + 1;
					end
            if (regWrite == 1)
                begin
						registradores[writeRegister] <= writeData;						  
                end
				else //adicionado
					begin
						registradores[writeRegister] <= registradores[writeRegister];
					end
        end
	    
    assign readData1 = registradores[readRegister1];
    assign readData2 = registradores[readRegister2];

endmodule	
			

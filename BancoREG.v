module BancoREG(readRegister1, readRegister2, writeRegister, writeData, readData1, readData2, clk, regWrite);
    input clk, regWrite;
    input [4:0] readRegister1, readRegister2, writeRegister;
    input [31:0] writeData;
    output [31:0] readData1, readData2;
    reg [31:0]registradores[31:0];

    always @ (posedge clk)
        begin
				registradores[0] = 32'b0;
            if (regWrite == 1)
                begin
                    registradores[writeRegister] = writeData;						  
                end
        end
	    
    assign readData1 = registradores[readRegister1];
    assign readData2 = registradores[readRegister2];

endmodule	
			

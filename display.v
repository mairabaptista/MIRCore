module display(inputDecimal, sDisplay);

	 input  [3:0]inputDecimal;
    reg[6:0]saidaDisplay;
	 output wire [6:0]sDisplay;
    
always @*
case (inputDecimal)
4'b0000 :      	//Hexadecimal 0
saidaDisplay = 7'b1111110;
4'b0001 :    		//Hexadecimal 1
saidaDisplay = 7'b0110000  ;
4'b0010 :  		// Hexadecimal 2
saidaDisplay = 7'b1101101 ; 
4'b0011 : 		// Hexadecimal 3
saidaDisplay = 7'b1111001 ;
4'b0100 :		// Hexadecimal 4
saidaDisplay = 7'b0110011 ;
4'b0101 :		// Hexadecimal 5
saidaDisplay = 7'b1011011 ;  
4'b0110 :		// Hexadecimal 6
saidaDisplay = 7'b1011111 ;
4'b0111 :		// Hexadecimal 7
saidaDisplay = 7'b1110000;
4'b1000 :     		 //Hexadecimal 8
saidaDisplay = 7'b1111111;
4'b1001 :    		//Hexadecimal 9
saidaDisplay = 7'b1111011 ;

default:
	saidaDisplay = 7'b1111110;

endcase
 assign sDisplay = ~saidaDisplay;
endmodule
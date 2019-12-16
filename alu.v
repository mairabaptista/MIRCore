module alu(opcode, input1, input2, result, shamt, sinalBranch, branch);

input [5:0]opcode;
input [4:0] shamt;
input [31:0] input1, input2;
input branch;
output reg [31:0]result;
output wire sinalBranch;
//output wire [5:0]saida1;
reg zero;
//assign saida1 = opcode;
always @(opcode or input1 or input2 or shamt)
	begin
		zero = 0;
		result = 0;
		case(opcode[5:0])
			6'b000000: result = input1 + input2;		//soma
			6'b000001: result = input1 - input2;		//subtracao
			6'b000010: result = input1 & input2;		//AND
			6'b000011: result = input1 | input2;		//OR
			6'b000100: result = ~input1;					//negacao
			6'b000101: result = input1 << shamt;		//shift left
			6'b000110: result = input1 >> shamt;		//shift right
			6'b000111: result = input1[15:0] * input2[15:0];	//multiplicacao 
			6'b001000: result = input1[15:0] / input2[15:0];	//divisao
			6'b001001: result = input1 % input2;				//modulo
			6'b001010: result = input1 - 1 ;				//decremento de 1
			6'b001011: result = input1 ^ input2;		//XOR
			
			6'b010010: zero = ( input1 != input2 ) ? 1'b1 : 1'b0; //branch on not equal
			
			6'b010001: zero = ( input1 == input2 ) ? 1'b1 : 1'b0;//branch on equal			  
			6'b010101: zero = ( input1 > input2 ) ? 1'b1 : 1'b0; //branch on > 
			
			6'b010111: result = input1 >= input2 ? 1'b1 : 1'b0; //set on greater or equal than							
			6'b011110: result = input1 == input2 ? 1'b1 : 1'b0;//set on equal 							
			6'b100000: result = input1 > input2 ? 1'b1 : 1'b0;//set on greater than			
			6'b100010: result = input1 != input2 ? 1'b1 : 1'b0;//set different
			6'b110000: result = (input1 < input2) ? 1'b1 : 1'b0;	//set less than
			6'b110001: result = (input1 <= input2) ? 1'b1 : 1'b0;	//set less equal than
			
			6'b011011: result = input1 + 1'b0; //move			
			6'b001111: result = input2; //li
							
			default result = 0;
		endcase
	end
	
	assign sinalBranch = zero & branch;
	
endmodule	
			

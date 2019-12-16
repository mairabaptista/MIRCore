module controlUnit(rdy,opcode, ALUMUX, 
						regWrite, regDest, ALUControl, memWrite, 
						memRead, memMUX, inputMUX, branch, jMUX, jrMUX, displayFlag, hlt, reset, jal, bios_select,
						write_flag, write_os, mux_hd_control, lcd_trd_msg);
	
	input rdy, reset;
	input [5:0]opcode;
	output reg hlt;				//flags do pc
	output reg branch;				//controle de branch
	output reg jMUX, jrMUX, jal; 		//controle de jumps
	output reg regDest;				//(regdst) mux antes do banco reg
	output reg regWrite; 			//controle de escrita 
	output reg ALUMUX;				//mux de antes da ALU
	output reg [5:0]ALUControl;	//contorle da ALU
	output reg memWrite;				//controle de escrita de memoria
	output reg memRead;				//controle de leitura de memoria
	output reg memMUX;				//MUX depois da DataMem
	output reg inputMUX;
	output reg displayFlag;	
	output reg bios_select;
	//output reg bios_reset;
	output reg write_flag; 			//flag de escrita na memoria de instrucoes
	output reg write_os; 			//flag de escrita na instmem a regiao do so
	output reg mux_hd_control; //flag de escolha da origem do dado
	output reg lcd_trd_msg;
	
	always @(*)
		begin
			//os valores base seguem os sinais de controle de uma instrução de tipo R
			regDest = 1'b1;
			regWrite = 1'b1;
			ALUControl = 6'b000000;
			ALUMUX = 1'b0;		
			memWrite = 1'b0;			
			memMUX = 1'b0;	
			branch = 1'b0;			
			hlt = 1'b0;		
			jrMUX = 1'b0;	
			jMUX = 1'b0;
			inputMUX = 1'b0;
			displayFlag = 1'b0;
			jal = 1'b0;	
			bios_select = 1'b0;
			//bios_reset = 1'b0;
			write_flag = 1'b0;
			write_os = 1'b0;
			mux_hd_control = 1'b0;
			lcd_trd_msg = 1'b0;
			
			case(opcode)
					6'b000000: //soma
						begin
						end
					6'b001100://soma com imediato
						begin
								ALUControl = 6'b000000;
								ALUMUX = 1'b1;
								regDest = 1'b0;
						end
					6'b000001: //subtração
						begin
								ALUControl = 6'b000001;
						end
					6'b001101: //subtração com imediato
						begin
								ALUMUX = 1'b1;
								ALUControl = 6'b000001;
								regDest = 1'b0;
						end
					6'b000111:	//multiplicacao
						begin
							ALUControl = 6'b000111;
						end
					6'b001000:	//divisao
						begin
							ALUControl = 6'b001000;
						end
					6'b000010:	//AND
						begin
							ALUControl = 6'b000010;
						end
					6'b000011: 	//OR
						begin
							ALUControl = 6'b000011;
						end
					6'b001011:	//XOR
						begin
							ALUControl = 6'b001011;
						end
					6'b000100:	//NOT
						begin
							ALUControl = 6'b000100;
						end
					6'b000101:	//shift left
						begin
							ALUControl = 6'b000101;
						end
					6'b000110: 	//shift right
						begin
							ALUControl = 6'b000110;
						end
					6'b001001:	//modulo
						begin
							ALUControl = 6'b001001;
						end

					6'b001110: 	//lw
						begin
							regDest = 1'b0;
							ALUMUX = 1'b1;
							memMUX = 1'b1;					
							//memRead = 1'b1;		
							//ALUControl = 6'b001110;
							ALUControl = 6'b000000;
						end
					6'b100110:	//la
						begin
							regDest = 1'b0;
							ALUMUX = 1'b1;
							memMUX = 1'b0;
							memRead = 1'b1;
							ALUControl = 6'b000000;
						end
					6'b001111:	//li
						begin
							regDest = 1'b0;
							ALUMUX = 1'b1;
							memMUX = 1'b0;
							memRead = 1'b1;
							//ALUControl = 6'b001111;
							ALUControl = 6'b001111;
						end
					6'b010000:	//sw
						begin
							ALUMUX = 1'b1;
							regWrite = 1'b0;
							memWrite = 1'b1;
							//ALUControl = 6'b010000;
							ALUControl = 6'b000000;
							//memMUX = 1'b1;
						end
					6'b010001: 	//beq
						begin
							branch = 1'b1;
							regWrite = 1'b0;							
							ALUControl = 6'b010001;
						end
					6'b010010:	//bneq
						begin
							branch = 1'b1;
							regWrite = 1'b0;	
							ALUControl = 6'b010010;
						end
					6'b010101: 	//bgt
						begin
							branch = 1'b1;
							regWrite = 1'b0;
							ALUControl = 6'b010101;
						end
					6'b010111:	//sget
						begin
							ALUControl = 6'b010111;
							ALUMUX = 1'b1;		
						end
					6'b011110: 	//set on equal 
						begin
							ALUControl = 6'b011110;
						end
					6'b100000:	//set on greater than
						begin
							ALUControl = 6'b100000;
						end
					6'b100010: //set different
						begin
							ALUControl = 6'b100010;
						end
					6'b110000:	//set less than
						begin
							ALUControl = 6'b110000;
						end
					6'b110001:	//set less equal than
						begin
							ALUControl = 6'b110001;
						end
					6'b011010: 	//jump
						begin
							regWrite = 1'b0;	
							jMUX = 1'b1;							
							ALUControl = 6'b011010;
						end
					6'b011001:  //jr
						begin
							regWrite = 1'b0;	
							jrMUX = 1'b1;		
							ALUControl = 6'b011001;
						end
					6'b100001:	//jal
						begin
							regWrite = 1'b0;	
							jMUX = 1'b1;							
							ALUControl = 6'b000000;
							jal = 1'b1;
						end
					6'b011011: 	//move	
						begin
							ALUControl = 6'b011011;
							ALUMUX = 1'b1;
							regDest = 1'b0;
						end
					6'b111111:	//output
						begin
							displayFlag = 1'b1;
							regDest = 1'b0;
							regWrite = 1'b0;
							if(rdy)	
								hlt = 1'b1;
							else
								hlt = 1'b0;							
						end
					6'b100101:	//input
						begin
							regDest = 1'b0;
							memMUX = 1'b0;
							memRead = 1'b1;
							inputMUX = 1'b1;
							ALUControl = 6'b000000;
							ALUMUX = 1'b1;
							if(rdy)	
								hlt = 1'b1;
							else
								hlt = 1'b0;								
						end
					6'b011100: 	//NOP
						begin
							regDest = 1'b0;
							regWrite = 1'b0;
						end
					6'b011101: 	//HALT
						begin
							hlt = 1'b1;
							regDest = 1'b0;
							regWrite = 1'b0;
						end
					6'b111110: 	//bios_select
						begin
							bios_select = 1'b1;
							regDest = 1'b0;
							regWrite = 1'b0;
							//bios_reset = 1'b1;
						end
					//SO
					6'b110010: //lhd
						begin
							regDest = 1'b0;
							mux_hd_control = 1'b1;
						end
					6'b110101: //smem
						begin
							regDest = 1'b0;
							regWrite = 1'b0;
							write_flag = 1'b1;
							write_os = 1'b1;
						end
					6'b110110: //lcd
						begin
							regDest = 1'b0;
							regWrite = 1'b0;
							lcd_trd_msg = 1'b1;
						end
					
					default:
						begin
							regDest = 1'b0;
							regWrite = 1'b0;
						end
		endcase
		if(reset)
		begin
			displayFlag = 1'b1;
		end
	end
	
	
endmodule 
module core(clk_button, clock50M, reset, switches, unidade, dezena, centena, mil, milhao, bilhao, trilhao, quatrilhao, outPC); 

	input clk_button, reset,clock50M;	
	wire clock, botaosaida, botaoBom;
	//Entrada FPGA
	input [15:0] switches;
	//Sinais de Controle
	wire regWrite, regDest, memWrite, memRead, memMUX, ALUMUX, inputMUX, branch, sinalBranch, jMUX, jrMUX, displayFlag, hlt;
	
	wire [31:0] Instruction, imediato_estendido, input_estendido_26_32, inmux_output, rdataout;	
	wire [31:0] rdata1, rdata2,saidaBREG2, saida_memMUX, saida_prejumpMUX, saidaAdder, saida_jmux, display, resultado, saidareg, entradaPC;	
	wire [4:0] saida_regmux;	
	wire [5:0] ALUCONTROL;	
	wire [9:0] saidaPC;
	
	
	output wire[9:0] outPC;
	output wire[6:0] unidade, dezena, centena,mil, milhao, bilhao, trilhao, quatrilhao;
	
	
	DeBounce db(.clk(clock50M), 
					 .n_reset(1'b1), 
					 .button_in(clk_button), //dará o enter
					 .DB_out(botaosaida));
					 
	Temporizador temp(.clock(clock50M), 
							.clockT(clock));
	
	maquinaEstados estados(.clk(clock), 
								  .db_out(botaosaida), 
								  .saida(botaoBom));
	
	pc PC(.clk(clock), 
			.reset(reset), 
			.hlt(hlt), 
			.address(entradaPC), 
			.newAddress(saidaPC),
			.outPC(outPC));
	
	InstructionMem instmem(.address(saidaPC), 
								  .clk(clock), 
								  .instructionOut(Instruction));
	
	controlUnit control(.clk(clock), 
							  .rdy(botaoBom),
							  .opcode(Instruction[31:26]),
							  .ALUMUX(ALUMUX), 
							  .regWrite(regWrite), 
							  .regDest(regDest), 
							  .ALUControl(ALUCONTROL), 
							  .memWrite(memWrite), 
							  .memRead(memRead), 
							  .memMUX(memMUX), 							  
							  .inputMUX(inputMUX),
							  .branch(branch),
							  .jMUX(jMUX), 
							  .jrMUX(jrMUX),
							  .displayFlag(displayFlag),
							  .hlt(hlt),
							  .reset(reset)); 
	
	MUX_INPUT input_mux(.entrada1(Instruction[15:0]), 
							  .entrada2(switches), 
							  .sinal(inputMUX), 
							  .saida(inmux_output));	
	
					  
	SE_16_32 extender_16_32(.sinal_entrada(inmux_output), 
									.sinal_estendido(imediato_estendido));
							  
	MUX_REGDEST mux_regdest(.entrada1(Instruction[20:16]), 
									.entrada2(Instruction[15:11]), 
									.sinal(regDest), 
									.saida(saida_regmux));	
	
	BancoREG breg(.readRegister1(Instruction[25:21]), 
					  .readRegister2(Instruction[20:16]), 
					  .writeRegister(saida_regmux), 
					  .writeData(saida_memMUX), 
					  .readData1(rdata1), 
					  .readData2(rdata2), 
					  .clk(clock), 
					  .regWrite(regWrite));					  
	
	
	SE_26_32 estensor_26_32(.sinal_entrada(Instruction[25:0]), 
									.sinal_estendido(input_estendido_26_32));
											
	MUX_ALU mux_alu(.entrada1(rdata2), 
						 .entrada2(imediato_estendido), 
						 .sinal(ALUMUX), 
						 .saida(saidaBREG2));					  
	
	alu ula(.opcode(ALUCONTROL), 
			  .input1(rdata1), 
			  .input2(saidaBREG2), 
			  .result(resultado),  
			  .shamt(Instruction[10:0]), 
			  .sinalBranch(sinalBranch),
			  .branch(branch));	

	DataMem dmem(.writeDataIN(rdata2),  
					 .address(resultado), 
					 .clk(clock), 
					 .memWrite(memWrite),
					 .display(display), 
					 .displayFlag(displayFlag),
					 .readDataOut(rdataout));
					 
	output_module(.entrada(display),
					  .dunidade(unidade), 
					  .ddezena(dezena), 
					  .dcentena(centena),
					  .dmil(mil), 
					  .dmilhao(milhao), 
					  .dbilhao(bilhao), 
					  .dtrilhao(trilhao), 
					  .dquatrilhao(quatrilhao));

	
	MUX_MEM mem_mux(.entrada1(resultado), 
						 .entrada2(rdataout), 
						 .sinal(memMUX), 
						 .saida(saida_memMUX));	
						 
	ADDER adder(.next_addr(saidaPC), 
					.extended_imm(imediato_estendido), 
					.saida(saidaAdder));
	
	MUX_PRE_JUMP pre_jump_mux(.entrada1(saidaPC), 
									  .entrada2(saidaAdder), 
									  .sinal(sinalBranch), 
									  .saida(saida_prejumpMUX));
						 
	MUX_JUMP jump_mux(.entrada1(saida_prejumpMUX), 
							.entrada2(input_estendido_26_32), 
							.sinal(jMUX), 
							.saida(saida_jmux));	
							
	MUX_JR jr_mux(.entrada1(saida_jmux), 
						 .entrada2(rdata1), 
						 .sinal(jrMUX), 
						 .saida(entradaPC));
endmodule 

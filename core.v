module core(clk_button, clock50M, reset, switches, unidade, dezena, centena, mil, milhao, bilhao, trilhao, quatrilhao, outPC, 
intrpt, bios_output, Instruction, stateOut, clock, bios_select,  bios_reset, saidaPC, lcd_on,lcd_blon,lcd_rw,lcd_en,lcd_rs, lcd_data); 

	input clk_button, reset,clock50M;	
	wire /*clock,*/ botaosaida, botaoBom;
	//Entrada FPGA
	input [15:0] switches;
	//Sinais de Controle
	wire regWrite, regDest, memWrite, memRead, memMUX, 
		  ALUMUX, inputMUX, branch, sinalBranch, jMUX, 
		  jrMUX, displayFlag, hlt, jal,
		  //a partir daqui, adicionados
		  write_flag, write_os, mux_hd_control, lcd_trd_msg;
	
	wire MODE; //user/kernel mode flag
	
	wire [31:0] input_instr, read_address;
	
	wire [31:0] Instruction, imediato_estendido, input_estendido_26_32, inmux_output, rdataout;	
	wire [31:0] rdata1, rdata2,saidaBREG2, saida_memMUX, saida_prejumpMUX, saidaAdder, saida_jmux, display, resultado, saidareg, entradaPC;	
	wire [4:0] saida_regmux;	
	wire [5:0] ALUCONTROL;	
	//wire [9:0] saidaPC;
	//new stuff
	//wire [31:0] bios_output;
	wire [31:0] selected_instruction;
	wire [31:0] rdata3;
	output bios_select,  bios_reset;
	wire write_hd; //bios_select,  bios_reset; //adicionados
	//wire intrpt;
	output wire clock;
	output wire stateOut;
	output wire [31:0] bios_output;
	output wire[9:0] outPC;
	output wire[9:0] saidaPC;
	output wire[6:0] unidade, dezena, centena,mil, milhao, bilhao, trilhao, quatrilhao;
	output wire intrpt;
	output wire [31:0] Instruction;
	
	wire [31:0] hd_output, saida_mux_hd;
	
	wire [31:0] adressHD;
	
	wire [31:0] shift_amount;
	
	output wire lcd_on,lcd_blon,lcd_rw,lcd_en,lcd_rs;
	output wire [7:0] lcd_data;
	
	DeBounce db(.clk(clock50M), 
					 .n_reset(1'b1), 
					 .button_in(clk_button), //dará o enter
					 .DB_out(botaosaida));
					 
	Temporizador temp(.clock(clock50M), 
							.clockT(clock));
	
	maquinaEstados estados(.clk(clock), 
								  .db_out(botaosaida), 
								  .saida(botaoBom));
								  
	INTERRUPTION_MODULE int_module (.clk(clock), 
											  .opcode(selected_instruction[31:26]), 
											  .intrpt(intrpt));
	
	pc PC(.clk(clock), 
			.reset(reset), 
			.hlt(hlt), 
			.address(entradaPC), 
			//.newAddress(saidaPC),
			.outPC(outPC),
			.bios_reset(bios_reset));	
	
	HD hd(.clk_auto(clock50M), 
			.clk(clock), 
			.write_flag(write_hd),  
			.input_data(rdata3), 
			.hd_output(hd_output),
			.address(rdata1) //adicionado
			);
	
			
	BIOS bios(.address(outPC),
				 .biosOut(bios_output), 
				 .clk_auto(clock50M));
	
	
	InstructionMem instmem(.address(outPC), 
								  .clk(clock), 
								  .instructionOut(Instruction),
								  .clk_auto(clock50M),
								  .write_flag(write_flag), //adicionado
								  .write_os(write_os), //adicionado
								  .input_instr(rdata2), //adicionado
								  .MODE(1'b0), //adicionado
								  .read_address(rdata1) //adicionado
								  );
	
	MUX_BIOS mux_bios(.mux_select(bios_select), 
							.clk(clock), 
							.rst(bios_reset), 
							.input_data_1(bios_output), 
							.input_data_2(Instruction), 
							.mux_output(selected_instruction),
							.state(stateOut));
	
	controlUnit control(//.clk(clock), 
							  .rdy(botaoBom),
							  .opcode(selected_instruction[31:26]),
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
							  .reset(reset),
							  .jal(jal), 
							  .bios_select(bios_select), //adicionado
							  //.bios_reset(bios_reset), 
							  .write_flag(write_flag), //adicionado
							  .write_os(write_os), //adicionado
							  .mux_hd_control(mux_hd_control), //adicionado
							  .lcd_trd_msg(lcd_trd_msg) //adicionado
							  ); 
	
	MUX_INPUT input_mux(.entrada1(selected_instruction[15:0]), 
							  .entrada2(switches), 
							  .sinal(inputMUX), 
							  .saida(inmux_output));	
	
					  
	SE_16_32 extender_16_32(.sinal_entrada(inmux_output), 
									.sinal_estendido(imediato_estendido));
							  
	MUX_REGDEST mux_regdest(.entrada1(selected_instruction[20:16]), 
									.entrada2(selected_instruction[15:11]), 
									.sinal(regDest), 
									.saida(saida_regmux));	
									
	MUX_HD mux_hd (.entrada1(saida_memMUX), 
						.entrada2(hd_output), 
						.sinal(mux_hd_control), 
						.saida(saida_mux_hd));
	
	BancoREG breg(.readRegister1(selected_instruction[25:21]), 
					  .readRegister2(selected_instruction[20:16]), 
					  .writeRegister(saida_regmux), 
					  .writeData(saida_mux_hd), 
					  .readData1(rdata1), 
					  .readData2(rdata2), 
					  .clk(clock), 
					  .regWrite(regWrite),
					  .PC(outPC),
					  .jal(jal));					  
	
	
	SE_26_32 estensor_26_32(.sinal_entrada(selected_instruction[25:0]), 
									.sinal_estendido(input_estendido_26_32));
											
	MUX_ALU mux_alu(.entrada1(rdata2), 
						 .entrada2(imediato_estendido), 
						 .sinal(ALUMUX), 
						 .saida(saidaBREG2));					  
	
	alu ula(.opcode(ALUCONTROL), 
			  .input1(rdata1), 
			  .input2(saidaBREG2), 
			  .result(resultado),  
			  .shamt(selected_instruction[10:0]), 
			  .sinalBranch(sinalBranch),
			  .branch(branch));	
			  
	MEM_SHIFTER mem_shifter(.proc_index(2), 
									.shift_amount(shift_amount)
									);

	DataMem dmem(.writeDataIN(rdata2),  
					 .address(resultado), 
					 .clk(clock), 
					 .memWrite(memWrite),
					 .display(display), 
					 .displayFlag(displayFlag),
					 .readDataOut(rdataout),
					 .clk_auto(clock50M),
					 .shift_amount(shift_amount) //adicionado
					 );
					 
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
						 
	ADDER adder(.next_addr(outPC), 
					.extended_imm(imediato_estendido), 
					.saida(saidaAdder));
	
	MUX_PRE_JUMP pre_jump_mux(.entrada1(outPC), 
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
						 
	LCD DISP(.CLOCK_50(clock50M),
				.SW(8'b0),
				.LCD_ON(lcd_on),
				.LCD_BLON(lcd_blon),
				.LCD_RW(lcd_rw),
				.LCD_EN(lcd_en),
				.LCD_RS(lcd_rs),
				.LCD_DATA(lcd_data),
				.offset(rdata2[15:0]),
				.lcd_trd_msg(lcd_trd_msg),
				.clk_div(clock)
	);
endmodule 

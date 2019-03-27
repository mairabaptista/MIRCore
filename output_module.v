module output_module(entrada, dunidade, ddezena, dcentena, dmil, dmilhao, dbilhao, dtrilhao, dquatrilhao);

	input [31:0] entrada;
	output wire [6:0] dunidade, dcentena, ddezena, dmil, dmilhao, dbilhao, dtrilhao, dquatrilhao;
	wire [3:0] unidade, centena, dezena, mil, milhao, bilhao, trilhao, quatrilhao;
	wire neg;
	
	
	bin_to_bcd BTB(.binary(entrada), 
						.neg(neg),  
						.first(unidade), 
						.second(dezena), 
						.third(centena), 
						.fourth(mil), 
						.fifth(milhao), 
						.sixth(bilhao), 
						.seventh(trilhao), 
						.eighth(quatrilhao));
		
	display dUnidade(.inputDecimal(unidade), 
								  .sDisplay(dunidade));
	display dDezena(.inputDecimal(dezena), 
							    .sDisplay(ddezena));
	display dCentena(.inputDecimal(centena), 
								  .sDisplay(dcentena));
	display dMil(.inputDecimal(mil), 
								  .sDisplay(dmil));
	display dMilhao(.inputDecimal(milhao), 
								  .sDisplay(dmilhao));
	display dBilhao(.inputDecimal(bilhao), 
								  .sDisplay(dbilhao));
	display dTrilhao(.inputDecimal(trilhao), 
								  .sDisplay(dtrilhao));
	display dQuatrilhao(.inputDecimal(quatrilhao), 
								  .sDisplay(dquatrilhao));
	
	
endmodule 

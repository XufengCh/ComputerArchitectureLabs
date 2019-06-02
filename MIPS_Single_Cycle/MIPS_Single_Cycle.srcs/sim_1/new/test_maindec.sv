`timescale 1ns / 1ps

module test_maindec();
    logic [5:0] op;
    logic memtoreg, memwrite;
    logic branch, alusrc;
	logic regdst, regwrite, jump, immext;
    logic [2:0] aluop;
    
    maindec MUT(op, memtoreg, memwrite, branch, alusrc, 
				regdst, regwrite, jump, aluop, immext);
	
	initial
	begin
			op = 6'b000000;		//R-TYPE
		#20	op = 6'b100011;     //LW
		#20	op = 6'b101011;     //SW
		#20	op = 6'b000100;     //BEQ
		#20	op = 6'b001000;     //ADDI
		#20	op = 6'b000010;     //J
		#20	op = 6'b000101;		//bne
		#20	op = 6'b001101;     //ori
		#20	op = 6'b001100;     //andi
	end
	
endmodule

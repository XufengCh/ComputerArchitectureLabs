`timescale 1ns / 1ps

module datapath(
    input 	logic		clk, reset, 
	input	logic		memtoreg, regdst, iord, alusrca, immext,
	input	logic [1:0] alusrcb, pcsrc,
	input	logic		irwrite, memwrite, regwrite, pcen, 
	input	logic [2:0] alucontrol, 
	input	logic [31:0]readdata, 
	
	output	logic		zero, 
	output	logic [31:0]addr, writedata, instr
    );
	
	logic [31:0] pc, pcnext;               //for PC logic
	logic [31:0] data;              //for instr/data memory
	logic [31:0] rega, wd3, rd1, rd2;                     //for regfile
	logic [4:0] writereg;
	logic [31:0] signimm, signimmsh, zeroimm, imm;       //for signimm
	logic [15:0] ie0, ies;
	logic [31:0] srca, srcb, aluresult, aluout;    //for alu
	
	//next PC logic
	flopenr#(32)   	pcreg(.clk(clk), .reset(reset), .en(pcen), .d(pcnext), .q(pc));
	//mux2#(32)		pcmux(.d0(aluresult), .d1(aluout), .s(pcsrc), .y(pcnext));
	mux4#(32)       pcmux(.d0(aluresult), .d1(aluout), .d2({pc[31:28], instr[25:0], 2'b00}), .d3(32'hxxxx_xxxx), 
	                       .s(pcsrc), .y(pcnext));
	
	//instr & data memory address logic
	mux2#(32)      	muxaddr(.d0(pc), .d1(aluout), .s(iord), .y(addr));

	//read instr & data memory
	flopenr#(32)	instrreg(.clk(clk), .reset(reset), .en(irwrite), .d(readdata), .q(instr));
	flopr#(32)		datareg(.clk(clk), .reset(reset), .d(readdata), .q(data));
	
	//register file logic
	mux2#(5)		muxwa3(.d0(instr[20:16]), .d1(instr[15:11]), .s(regdst), .y(writereg));
	mux2#(32)		muxwd3(.d0(aluout), .d1(data), .s(memtoreg), .y(wd3));
	regfile			rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]), 
						.wa3(writereg), .wd3(wd3), .rd1(rd1), .rd2(rd2));
	flopr#(32)		ra(.clk(clk), .reset(reset), .d(rd1), .q(rega));
	flopr#(32)		rb(.clk(clk), .reset(reset), .d(rd2), .q(writedata));
	
	//ALU logic
	//signext 		se(instr[15:0], signimm);
	dmux#(16)		extDmux(.data(instr[15:0]), .s(immext), .y0(ies), .y1(ie0));
	zeroext			ze(ie0, zeroimm);
	signext			se(ies, signimm);
	mux2#(32)		extmux(.d0(signimm), .d1(zeroimm), .s(immext), .y(imm));
	
	sl2				immsh(.a(signimm), .y(signimmsh));
	
	mux2#(32)		srcamux(.d0(pc), .d1(rega), .s(alusrca), .y(srca));
	mux4#(32)		srcbmux(.d0(writedata), .d1(32'b100), .d2(imm), .d3(signimmsh), 
							.s(alusrcb), .y(srcb));
	ALU_32bit		alu(.a(srca), .b(srcb), .alucont(alucontrol), .result(aluresult), .zf(zero));
	flopr#(32)		alureg(.clk(clk), .reset(reset), .d(aluresult), .q(aluout));
	
endmodule

`timescale 1ns / 1ps

module controller(
	input	logic		clk, reset,
    input	logic [5:0]	op, funct,
	input	logic		zero,
	output	logic		memtoreg, regdst, iord, alusrca,
	output	logic [1:0] alusrcb, pcsrc, 
	output	logic		irwrite, memwrite, regwrite, pcen,
	output	logic [2:0] alucontrol, 
	output  logic       immext
    );
	
	logic [1:0]	aluop;
	logic branch, pcwrite;
	
	maindec		MD(.clk(clk), .reset(reset), .op(op), .pcwrite(pcwrite), 
					.memwrite(memwrite), .irwrite(irwrite), .regwrite(regwrite), 
					.alusrca(alusrca), .branch(branch), .iord(iord), .memtoreg(memtoreg), 
					.regdst(regdst), .alusrcb(alusrcb), .pcsrc(pcsrc), .aluop(aluop), .immext(immext));
	aludec		AD(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));
	
	assign pcen = (branch & zero) | pcwrite;
	
endmodule

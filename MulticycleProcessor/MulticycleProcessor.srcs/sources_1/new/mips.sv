`timescale 1ns / 1ps

module mips(
	input   logic           clk, reset, 
	input   logic [31:0]    readdata,
    output  logic           memwrite,
    output  logic [31:0]    writedata, dataadr
    );
	
	logic 		memtoreg, regdst, iord, alusrca, 
				irwrite, regwrite, pcen, zero, immext;
	logic [1:0] alusrcb, pcsrc;
	logic [2:0] alucontrol;
	logic [31:0]instr;
	
	controller	c(.clk(clk), .reset(reset), .op(instr[31:26]), .funct(instr[5:0]), 
					.zero(zero), .memtoreg(memtoreg), .regdst(regdst), .iord(iord), 
					.pcsrc(pcsrc), .alusrca(alusrca), .alusrcb(alusrcb), .irwrite(irwrite),
					.memwrite(memwrite), .regwrite(regwrite), .pcen(pcen), .alucontrol(alucontrol), .immext(immext));
	datapath	dp(.clk(clk), .reset(reset), .memtoreg(memtoreg), .regdst(regdst), .iord(iord), 
					.pcsrc(pcsrc), .alusrca(alusrca), .alusrcb(alusrcb), .irwrite(irwrite), 
					.memwrite(memwrite), .regwrite(regwrite), .pcen(pcen), .alucontrol(alucontrol), 
					.readdata(readdata), .zero(zero), .addr(dataadr), .writedata(writedata), .instr(instr), .immext(immext));
	
endmodule

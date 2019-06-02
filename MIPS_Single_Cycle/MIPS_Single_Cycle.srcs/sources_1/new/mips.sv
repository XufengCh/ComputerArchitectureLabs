`timescale 1ns / 1ps

module mips(
    input   logic           clk, reset, 
    output  logic [31:0]    pc,
    input   logic [31:0]    instr,
    output  logic           memwrite,
    output  logic [31:0]    aluout, writedata, 
    input   logic [31:0]    readdata
    );
    
    logic       memtoreg, alusrc, regdst,
                regwrite, jump, pcsrc, zero, immext;
    logic [2:0] alucontrol;
    
    controller  c(instr[31:26], instr[5:0], zero, 
                    memtoreg, memwrite, pcsrc, 
                    alusrc, regdst, regwrite, jump, alucontrol, immext);
    datapath    dp(.clk(clk), .reset(reset), .memtoreg(memtoreg), .pcsrc(pcsrc),
                    .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump),
                    .alucontrol(alucontrol), .instr(instr), .zero(zero), .pc(pc), 
                    .aluout(aluout), .writedata(writedata), .readdata(readdata), .immext(immext));
    
endmodule

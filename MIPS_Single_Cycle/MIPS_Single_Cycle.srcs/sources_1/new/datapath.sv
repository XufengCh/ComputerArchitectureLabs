`timescale 1ns / 1ps

module datapath(
    input   logic           clk, reset,
    input   logic           memtoreg, pcsrc,
    input   logic           alusrc, regdst,
    input   logic           regwrite, jump,
    input   logic [2:0]     alucontrol,
    input   logic [31:0]    instr,
    input   logic [31:0]    readdata,
    input   logic           immext,     //new
    
    output  logic           zero,
    output  logic [31:0]    pc,
    output  logic [31:0]    aluout, writedata
    );
    
    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;   //use for updating PC
    logic [31:0] signimm, signimmsh, zeroimm, imm;    //use for Imm
    logic [15:0] ie0, ies;
    logic [31:0] srca, srcb;    //use for ALU
    logic [31:0] result;
    
    //next PC logic
    flopr#(32)  pcreg(.clk(clk), .reset(reset), .d(pcnext), .q(pc));
    adder       pcadd1(.a(pc), .b(32'b100), .y(pcplus4));
    sl2         immsh(.a(signimm), .y(signimmsh));
    adder       pcadd2(.a(pcplus4), .b(signimmsh), .y(pcbranch));
    mux2#(32)   pcbrmux(.d0(pcplus4), .d1(pcbranch), .s(pcsrc), .y(pcnextbr));
    mux2#(32)   pcmux(.d0(pcnextbr), .d1({pcplus4[31:28], instr[25:0], 2'b00}),
                        .s(jump), .y(pcnext));
                        
    //register file logic
    regfile     rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]),
                    .wa3(writereg), .wd3(result), .rd1(srca), .rd2(writedata));
    mux2#(5)    wrmux(instr[20:16], instr[15:11], regdst, writereg);
    mux2#(32)   resmux(aluout, readdata, memtoreg, result);
        
    //ALU logic
    dmux#(16)   extDmux(.data(instr[15:0]), .s(immext), .y0(ies), .y1(ie0));
    zeroext     ze(ie0, zeroimm);
    signext     se(ies, signimm);
    mux2#(32)   extmux(.d0(signimm), .d1(zeroimm), .s(immext), .y(imm));
    
    mux2#(32)   srcbmux(writedata, imm, alusrc, srcb);
    ALU_32bit   alu(.a(srca), .b(srcb), .alucont(alucontrol), .result(aluout), .zf(zero)); 
    
endmodule

`timescale 1ns / 1ps

module controller(
    input   logic [5:0] op, funct,
    input   logic       zero,
    output  logic       memtoreg, memwrite,
    output  logic       pcsrc, alusrc,
    output  logic       regdst, regwrite,
    output  logic       jump,
    output  logic [2:0] alucontrol,
    output  logic       immext          //new
    );
    
    //logic [1:0] aluop;
    logic [2:0] aluop;
    logic branch;
    
    maindec MD(.op(op), .memtoreg(memtoreg), .memwrite(memwrite), .branch(branch), 
                .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .aluop(aluop), .immext(immext));
    aludec  AD(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));
    
    //assign pcsrc = branch & zero;
    //for BEQ or BNE
    assign pcsrc = (branch & zero) | ((op == 6'b000101) & (~zero));
    
endmodule

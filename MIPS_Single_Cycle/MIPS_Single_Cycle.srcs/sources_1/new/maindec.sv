`timescale 1ns / 1ps

module maindec(
    input   logic [5:0] op,
    output  logic       memtoreg, memwrite,
    output  logic       branch, alusrc,
    output  logic       regdst, regwrite,
    output  logic       jump,
    //output  logic [1:0] aluop
    output  logic [2:0] aluop,
    output  logic       immext      
    );
    
    logic [10:0] controls = 11'b000_0000_0000;
    
    assign {regwrite, regdst, alusrc, branch, memwrite, 
            memtoreg, jump, aluop, immext} = controls;
            
    always_comb
        case(op)
            6'b000000:  controls <= 11'b1100_0000_100;  //R-TYPE
            6'b100011:  controls <= 11'b1010_0100_000;  //LW
            6'b101011:  controls <= 11'b0010_1000_000;  //SW
            6'b000100:  controls <= 11'b0001_0000_010;  //BEQ
            6'b001000:  controls <= 11'b1010_0000_000;  //ADDI
            6'b000010:  controls <= 11'b0000_0010_000;  //J
            //To be continued...
            6'b000101:  controls <= 11'b0000_0000_010;  //bne
            6'b001101:  controls <= 11'b1010_0000_111;  //ori
            6'b001100:  controls <= 11'b1010_0001_001;  //andi
            default:    controls <= 11'bxxxx_xxxx_xxx;  //illegal op
        endcase
endmodule

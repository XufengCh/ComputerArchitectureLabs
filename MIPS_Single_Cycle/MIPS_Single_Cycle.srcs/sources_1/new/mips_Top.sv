`timescale 1ns / 1ps

module mips_Top(
    input   logic           clk, reset, 
    output  logic [31:0]    writedata, dataadr,
    output  logic           memwrite
    );
    
    logic [31:0] pc, instr, readdata;
    
    //instantiate processor and memories
    mips MIPS(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memwrite(memwrite), 
                .aluout(dataadr), .writedata(writedata), .readdata(readdata));
    imem IMEM(.a(pc[7:2]), .rd(instr));
    dmem DMEM(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata), .rd(readdata)); 
    
endmodule

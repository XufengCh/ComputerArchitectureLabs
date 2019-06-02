`timescale 1ns / 1ps

module dmem(
    input   logic clk, we,
    input   logic [31:0] a, wd,
    output  logic [31:0] rd
    );
    
    //logic [31:0] RAM [63:0];
    logic [31:0] RAM [255:0];   //for IO
    
    assign rd = RAM[a[31:2]];   //word aligned
    
    always_ff @(posedge clk)
        if(we)  RAM[a[31:2]] <= wd;
    
endmodule

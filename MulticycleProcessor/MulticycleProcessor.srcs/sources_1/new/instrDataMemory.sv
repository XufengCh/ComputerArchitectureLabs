`timescale 1ns / 1ps

module instrDataMemory(
    input   logic       clk, we,
    input   logic [31:0]addr, writeData,
    output  logic [31:0]readData
    );
    
    //logic [31:0] readimem, readdmem;
    
    //imem    IMEM(.a(addr[7:2]), .rd(readimem));
    //dmem    DMEM(.clk(clk), .we(we), .a(addr), .wd(writeData), .rd(readdmem));
    
    //assign readData = (addr < 'h100)? readimem : readdmem;
    
    logic [31:0] RAM [255:0];   //for IO
    
    assign readData = RAM[addr[31:2]];   //word aligned
    
    always_ff @(posedge clk)
        if(we)  RAM[addr[31:2]] <= writeData;
    
    initial
        $readmemh("memfile.dat", RAM);
        //$readmemh("io.dat", RAM);
    
endmodule

`timescale 1ns / 1ps

module MipsIO_Top(
	input   logic       CLK100MHZ,
    input   logic       BTNC, BTNL, BTNR, 
    input   logic [15:0]SW,
    
    output  logic [7:0] AN,
    output  logic       DP,
    output  logic [6:0] A2G
    );
	
	logic writeEN;
	logic [31:0] writeData, dataAddr, readData;
	
	mips MipsIO(.clk(CLK100MHZ), .reset(BTNC), .readdata(readData), 
				.memwrite(writeEN), .writedata(writeData), .dataadr(dataAddr));
	MemoryDecoder MD(.clk(CLK100MHZ), .writeEN(writeEN), .addr(dataAddr), 
						.writedata(writeData), .readdata(readData), .IOclock(~CLK100MHZ),
						.reset(BTNC), .btnL(BTNL), .btnR(BTNR), .switch(SW), .an(AN), .dp(DP), .a2g(A2G));
	
endmodule

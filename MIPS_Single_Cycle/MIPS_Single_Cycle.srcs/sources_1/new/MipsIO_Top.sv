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
    logic [31:0] writeData, dataAdr, pc, instr, readData;
    
    mips MipsUseIO(.clk(CLK100MHZ), .reset(BTNC), .pc(pc), .instr(instr), .memwrite(writeEN),
					.aluout(dataAdr), .writedata(writeData), .readdata(readData));
	imem IMEM(.a(pc[7:2]), .rd(instr));
	DataMemoryDecoder	DMD(.clk(CLK100MHZ), .writeEN(writeEN), .addr(dataAdr), 
							.writeData(writeData), .readData(readData),
							.IOclock(~CLK100MHZ), .reset(BTNC), .btnL(BTNL), .btnR(BTNR),
							.switch(SW), .an(AN), .dp(DP), .a2g(A2G));
    
endmodule

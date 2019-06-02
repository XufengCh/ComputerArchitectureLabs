`timescale 1ns / 1ps

module mips_Top(
	input  logic           clk, reset, 
    output logic [31:0]    writedata, dataadr,
    output logic           memwrite
    );
	
	logic [31:0] readdata;
	
	mips MIPS(.clk(clk), .reset(reset), .readdata(readdata), 
				.memwrite(memwrite), .writedata(writedata), .dataadr(dataadr));
	instrDataMemory	IDM(.clk(clk), .we(memwrite), .addr(dataadr), 
						.writeData(writedata), .readData(readdata));
	
endmodule

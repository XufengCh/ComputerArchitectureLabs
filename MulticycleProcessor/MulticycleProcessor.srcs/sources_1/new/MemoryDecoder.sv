`timescale 1ns / 1ps

module MemoryDecoder(
	input	logic		clk, writeEN,
	input	logic [31:0]addr, writedata, 
	output	logic [31:0]readdata, 
	        
	input	logic IOclock, 
	input	logic reset, 
	input	logic btnL, btnR, 
	input	logic [15:0] switch, 
	output	logic [7:0] an,
	output	logic dp, 
	output	logic [6:0] a2g
    );
	
	logic pRead, pWrite, mWrite;
	logic [11:0] led;
	logic [31:0] pReadData, memReadData;
	
	//whether reading from IO is enabled
	assign pRead = addr[7];
	//whether writing to IO is enabled
	assign pWrite = addr[7] & writeEN;
	//write to memory
	assign mWrite = writeEN & (addr[7] == 0);
	
	//access instruction and data
	instrDataMemory IDMem(.clk(clk), .we(writeEN), .addr(addr), 
							.writeData(writedata), .readData(memReadData));
	//IO
	IO io(.clk(IOclock), .reset(reset), .pRead(pRead), .pWrite(pWrite), 
			.addr(addr[3:2]), .pWriteData(writedata), .pReadData(pReadData),
			.buttonL(btnL), .buttonR(btnR), .switch(switch), .led(led));
			
	//READ
    mux2#(32)   readmux(.d0(memReadData), .d1(pReadData), .s(addr[7]), .y(readdata));
	
	//DISPLAY
	x7seg X7SEG(.x({switch, 4'b0000, led}), .clk(IOclock), .clr(reset), .a2g(a2g), .an(an), .dp(dp));
	
endmodule

`timescale 1ns / 1ps

module test_regFile();
    logic       clk;
    logic       regWriteEn;
    logic [4:0] regWriteAddr;
    logic [31:0]regWriteData;
    logic [4:0] rsAddr, rtAddr;
    logic [31:0]rsData, rtData;
    
    regfile MUT_REG(.clk(clk), .we3(regWriteEn), .wa3(regWriteAddr), .wd3(regWriteData), 
                    .ra1(rsAddr), .rd1(rsData), .ra2(rtAddr), .rd2(rtData));
                    
    initial
    begin
        clk = 0;
        regWriteEn = 0;
        regWriteAddr = 0;
		regWriteData = 0;
		rsAddr = 0;
		rtAddr = 0;
		//Wait 100ns
		#100
		//Add signal
		regWriteEn = 1;
		regWriteData = 32'h1234abcd;
    end 
	
	//set clk
	parameter PERIOD = 20;
	always
	begin
		clk = 1'b0;
		#(PERIOD/2)	clk = 1'b1;
		#(PERIOD/2);
	end
	
	//set signal
	always
	begin
		regWriteAddr = 8;
		rsAddr = 8;
		#PERIOD;
	end

endmodule

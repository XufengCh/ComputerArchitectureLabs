`timescale 1ns / 1ps

module test_mipsIO();
    logic clk, btnc, btnl, btnr, dp;
    logic [15:0] sw;
    logic [7:0] an;
    logic [6:0] a2g;
    
    MipsIO_Top MUT_mipsio(clk, btnc, btnl, btnr, sw, an, dp, a2g);
    
    initial
    begin
        btnc <= 1;
        #20;
        btnc <= 0;
    end
    
    always
    begin
        clk <= 1; #5;
        clk <= 0; #5;    
    end
    
    always
    begin
        sw = 16'h0101;  #5
        btnr = 1'b1;    #5
        btnl = 1'b1;
    end

endmodule

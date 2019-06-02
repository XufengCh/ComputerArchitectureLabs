`timescale 1ns / 1ps

module zeroext(
    input   logic   [15:0] a,
    output  logic   [31:0] y
    );
    
    assign y = {16'b0000_0000_0000_0000, a};
    
endmodule

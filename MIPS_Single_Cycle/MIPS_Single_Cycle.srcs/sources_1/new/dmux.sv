`timescale 1ns / 1ps

module dmux #(parameter WIDTH = 8)(
    input   logic [WIDTH-1:0]   data,
    input   logic s,
    output  logic [WIDTH-1:0]   y0, y1
    );
    
    assign y0 = (s == 0) ? data : 0;
    assign y1 = (s == 1) ? data : 0;
    
endmodule

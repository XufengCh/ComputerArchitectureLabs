`timescale 1ns / 1ps

module ALU_Top(
    input logic [15:0] SW,
    input logic BTNL, BTNC,
    input logic CLK100MHZ,
    output logic CA,
    output logic CB,
    output logic CC,
    output logic CD,
    output logic CE,
    output logic CF,
    output logic CG,
    output logic [7: 0] AN,
    output logic DP,
    output logic [3:0] LED
    );
    
    //logic [2:0] alucont;
    logic [31:0] result;
    
    switch_mode SM(.button(BTNL), .alucont(LED[2:0]));
    ALU_32bit ALU(.alucont(LED[2:0]), .a({'h000000, SW[15:8]}), .b({'h000000, SW[7:0]}), .result(result), .zf(LED[3]));
    x7seg X7SEG(.x({SW[15:0], 4'b0000, result[11:0]}), .clk(CLK100MHZ), .clr(BTNC), .a2g({CG, CF, CE, CD, CC, CB, CA}), .an(AN), .dp(DP));
    
    
    //assign LED[3] = 0;
    //assign LED[2:0] = alucont;

endmodule

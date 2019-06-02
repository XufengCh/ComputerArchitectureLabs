`timescale 1ns / 1ps

module test_ALU();
    logic zf;
    logic [31:0] a, b, r;
    logic [2:0] c;
    
    ALU_32bit alu(c, a, b, r, zf);
    
    initial
    begin
        //add
            a=0;    b=0;    c=2;
        #10 a=0;    b='hffffffff;  c=2;
        #10 a=1;    b='hffffffff;  c=2;
        #10 a='hff; b=1;    c=2;
        //sub
        #10 a=0;    b=0;    c=6;
        #10 a=0;    b='hffffffff;   c=6;
        #10 a=1;    b=1;   c=6;
        #10 a='h100;  b=1;   c=6;
        //slt
        #10 a=0;    b=0;    c=7;
        #10 a=0;    b=1;    c=7;
        #10 a=0;    b='hffffffff;   c=7;
        #10 a=1;    b=0;    c=7;
        #10 a='hffffffff;   b=0;    c=7;
        //and
        #10 a='hffffffff;   b='hffffffff;   c=0;
        #10 a='hffffffff;   b='h12345678;   c=0;
        #10 a='h12345678;   b='h87654321;   c=0;
        #10 a=0;    b='hffffffff;   c=0;
        //or
        #10 a='hffffffff;   b='hffffffff;   c=1;
        #10 a='h12345678;   b='h87654321;   c=1;
        #10 a=0;    b='hffffffff;   c=1;
        #10 a=0;    b=0;    c=1;
    end
endmodule

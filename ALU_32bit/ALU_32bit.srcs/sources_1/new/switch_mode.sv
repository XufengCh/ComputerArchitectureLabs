`timescale 1ns / 1ps

module switch_mode(
    input   logic       button,
    output  logic [2:0] alucont
    );
    
    logic [2:0] state = 'b000;
    
    parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3,
              s4 = 4, s5 = 5, s6 = 6;
    
    always_ff @(negedge button)
    begin
        case(state)
            s0: state <= s1;
            s1: state <= s2;
            s2: state <= s3;
            s3: state <= s4;
            s4: state <= s5;
            s5: state <= s6;
            s6: state <= s0;
            default: state <= s0;
        endcase
    end
    
    always_comb
    begin
        case(state)
            s0: alucont = 'b000;    //a AND b
            s1: alucont = 'b001;    //a OR b
            s2: alucont = 'b010;    //a + b
            s3: alucont = 'b100;    //a AND ~b
            s4: alucont = 'b101;    //a OR ~b
            s5: alucont = 'b110;    //a - b
            s6: alucont = 'b111;    //SLT
        endcase
    end    
endmodule

`timescale 1ns / 1ps

module ALU_32bit(
    input   logic [2:0] alucont,
    input   logic [31:0] a,
    input   logic [31:0] b,
    output  logic [31:0] result,
    output  logic zf
    );
    
    logic [32:0] temp;
    
    always_comb
    begin
        temp = 0;
        result = 0;
        case(alucont)
            3'b000:     result = a & b;
            3'b001:     result = a | b;
            3'b010:     //a + b
                    begin
                        temp = {1'b0,a} + {1'b0,b};
                        result = temp[31:0];    
                    end
            3'b100:     result = a & (~b);
            3'b101:     result = a | (~b);
            3'b110:     //a - b
                    begin
                        temp = {1'b0,a} - {1'b0,b};
                        result = temp[31:0];
                    end
            3'b111:     //result = (a < b); 
                    begin
                        temp = {1'b0,a} - {1'b0,b};
                        result[0] = temp[31];
                    end
            default:    result = a;
        endcase
        zf = (result == 0);
    end
endmodule

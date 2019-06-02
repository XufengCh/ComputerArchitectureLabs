module Hex7Seg(
    input  logic [3:0] data,
    input  logic [2:0] s,
    output logic [6:0] a2g); 
    // A2G format {g, f, e, d, c, b, a} 
    always_comb
    begin
        case (data) 
            'h0: a2g = 7'b1000000; 
            'h1: a2g = 7'b1111001; 
            'h2: a2g = 7'b0100100; 
            'h3: a2g = 7'b0110000; 
            'h4: a2g = 7'b0011001; 
            'h5: a2g = 7'b0010010; 
            'h6: a2g = 7'b0000010; 
            'h7: a2g = 7'b1111000; 
            'h8: a2g = 7'b0000000; 
            'h9: a2g = 7'b0010000; 
            'hA: a2g = 7'b0001000; 
            'hB: a2g = 7'b0000011; 
            'hC: a2g = 7'b1000110; 
            'hD: a2g = 7'b0100001; 
            'hE: a2g = 7'b0000110; 
            'hF: a2g = 7'b0001110; 
        default: a2g = 7'b1000000; //0
        endcase
        if(s == 'b011)  a2g = 7'b0110111;
    end
endmodule
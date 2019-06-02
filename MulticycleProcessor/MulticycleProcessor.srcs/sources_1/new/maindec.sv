`timescale 1ns / 1ps

module maindec(
    input   logic       clk, reset,
    input   logic [5:0] op,
    output  logic       pcwrite, memwrite, irwrite, regwrite,
    output  logic       alusrca, branch, iord, memtoreg, regdst, 
    output  logic [1:0] alusrcb, pcsrc,
    output  logic [1:0] aluop, 
    output  logic       immext
    );
    
    //States
    parameter FETCH     = 4'b0000;
    parameter DECODE    = 4'b0001;
    parameter MEMADR    = 4'b0010;
    parameter MEMRD     = 4'b0011;
    parameter MEMWB		= 4'b0100;
	parameter MEMWR		= 4'b0101;
	parameter RTYPEEX 	= 4'b0110;
	parameter RTYPEWB	= 4'b0111;
	parameter BEQEX		= 4'b1000;
	parameter ADDIEX	= 4'b1001;
	parameter ADDIWB	= 4'b1010;
	parameter JEX		= 4'b1011;
	parameter ANDIEX	= 4'b1100;
	//To be continued...
	
	//op code
	parameter LW	= 6'b100011;
	parameter SW	= 6'b101011;
	parameter RTYPE	= 6'b000000;
	parameter BEQ 	= 6'b000100;
	parameter ADDI 	= 6'b001000;
	parameter J		= 6'b000010;
	parameter ANDI	= 6'b001100;
	//To be continued...
	
	logic [3:0] state, nextstate;
	//logic [14:0]controls = 15'b0000_0000_0000_000;
	logic [15:0]controls = 16'b0000_0000_0000_0000;
	
	always_ff @(posedge clk, posedge reset)
	if(reset) state <= FETCH;
	else state <= nextstate;
	
	always_comb
	case(state)
		FETCH:		nextstate = DECODE;
		DECODE:		
			begin
				case(op)
					LW:		nextstate = MEMADR;
					SW:		nextstate = MEMADR;
					RTYPE:	nextstate = RTYPEEX;
					BEQ:	nextstate = BEQEX;
					ADDI:	nextstate = ADDIEX;
					J:		nextstate = JEX;
					ANDI:	nextstate = ANDIEX;
					default:nextstate = 4'bxxxx;
				endcase
			end
		MEMADR:
			begin
				case(op)
				LW:		nextstate = MEMRD;
				SW:		nextstate = MEMWR;
				default:nextstate = 4'bxxxx;
				endcase
			end
		MEMRD:		nextstate = MEMWB;
		MEMWB:		nextstate = FETCH;
		MEMWR:		nextstate = FETCH;
		RTYPEEX:	nextstate = RTYPEWB;
		RTYPEWB:	nextstate = FETCH;
		BEQEX:		nextstate = FETCH;
		ADDIEX:		nextstate = ADDIWB;
		ADDIWB:		nextstate = FETCH;
		JEX:		nextstate = FETCH;
		ANDIEX:		nextstate = ADDIWB;
		default:	nextstate = 4'bxxxx;
	endcase
	
	assign {immext, pcwrite, memwrite, irwrite, regwrite, alusrca, branch,
			iord, memtoreg, regdst, alusrcb, pcsrc, aluop} = controls;
	
	always_comb
	case(state)
		FETCH:	controls = 16'h5010;
		DECODE:	controls = 16'h0030;
		MEMADR:	controls = 16'h0420;
		MEMRD:	controls = 16'h0100;
		MEMWB:	controls = 16'h0880;
		MEMWR:	controls = 16'h2100;
		RTYPEEX:controls = 16'h0402;
		RTYPEWB:controls = 16'h0840;
		BEQEX:	controls = 16'h0605;
		ADDIEX:	controls = 16'h0420;
		ADDIWB:	controls = 16'h0800;
		JEX:	controls = 16'h4008;
		ANDIEX:	controls = 16'h8423;
		default:controls = 16'hxxxx;
	endcase
    
endmodule

`timescale 1ns/1ns
module prog_mem(input wire p, input wire[4:0] add, input wire[31:0] inst, output reg[31:0]prog);

reg[7:0] in_reg[31:0];

always @* begin
if(p) begin
in_reg[add]<=inst[7:0];
in_reg[add+1]<=inst[15:8];
in_reg[add+2]<=inst[23:16];
in_reg[add+3]<=inst[31:24];
prog<=32'bz;
end
if(!p) begin
prog[7:0]<=in_reg[add];
prog[15:8]<=in_reg[add+1];
prog[23:16]<=in_reg[add+2];
prog[31:24]<=in_reg[add+3];
end
end
endmodule

module prog_mem_tb();
reg p;
reg[4:0] add;
reg[31:0] inst;
wire[31:0] prog;
integer i;

prog_mem m1(p,add,inst,prog);

initial begin
p=1;
for(i=0;i<32;i=i+4) begin
add=i;
inst=i;
#50;
end
#100
p=0;
for(i=0;i<32;i=i+4) begin
add=i;
#50;
end

#500
$finish();
end
endmodule

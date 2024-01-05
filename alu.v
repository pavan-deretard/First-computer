module alu(input wire[2:0] inst,input wire[7:0] operand_1,operand_2, output reg[7:0] sol);
always @* begin
case(inst)
	3'b01:sol=operand_1+operand_2;
	3'b10:sol=operand_1-operand_2;
	default:sol=8'bz;
endcase
end
endmodule

module alu_tb();
wire[7:0] sol;
reg[7:0] operand_1,operand_2;
reg[2:0] inst; 
alu a(.sol(sol),.inst(inst),.operand_1(operand_1),.operand_2(operand_2));
initial begin
inst=0;
operand_1=$random;
operand_2=$random;
#50
inst=1;
operand_1=$random;
operand_2=$random;
#50
inst=2;
operand_1=$random;
operand_2=$random;
#50
$finish();
end
endmodule

module alu(input wire clk, input wire[3:0] inst,input wire[7:0] operand_1,operand_2, output reg[7:0] sol);
reg[7:0] in_sol;
always @* begin
case(inst)
	1:in_sol<=operand_1+operand_2; //add
	2:in_sol<=operand_1-operand_2;	//sub
	3:in_sol<=operand_1 & operand_2;	//and
	4:in_sol<=operand_1 | operand_2;	 //or
	5:in_sol<=operand_1 ^ operand_2;	//xor
	6:in_sol<=~operand_1;				//not
	7:in_sol<=operand_1<<operand_2;	//shift left
	8:in_sol<=operand_1>>operand_2;	//shift right
	9:in_sol<=operand_1==operand_2?8'h01:8'h00; //equality comparitor
	
	default:in_sol<=8'bz;
endcase
end
always @(posedge clk) begin
sol<=in_sol;
end

endmodule

module alu_tb();
wire[7:0] sol;
reg[7:0] operand_1,operand_2;
reg[3:0] inst; 
reg clk;
alu a(.clk(clk),.sol(sol),.inst(inst),.operand_1(operand_1),.operand_2(operand_2));
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

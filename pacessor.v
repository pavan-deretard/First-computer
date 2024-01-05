`timescale 1ns/1ns
module pacessor(input wire clk,rst_master, input wire[31:0] inst,output reg[4:0] add_o, output reg[7:0] op);

wire rst,rst_in;
or o(rst,rst_master,rst_in);

wire pc_inc,jmp,w_r;
wire[2:0] alu_inst;
wire[4:0] add;
wire[7:0] operand_1,operand_2,sol;
wire[4:0] jmp_add;
wire[1:0] op_sel;

always @* begin
add_o<=add;
if(op_sel[1]) begin
case(op_sel[0])
0:op=sol;
1:op=operand_1[7:0];
endcase
end
else op=8'hzz;
end
program_counter pc(pc_inc,rst,clk,jmp,jmp_add,add);
reg_bank rb(w_r,inst[19:16],inst[11:8],inst[3:0],inst[15:8],operand_1[7:0],operand_2);
alu al(alu_inst,operand_1,operand_2,sol);
decode dc(inst,w_r,rst_in,pc_inc,jmp,op_sel,jmp_add,alu_inst);
endmodule

module prog_mem();
reg clk,rst_master;
reg[31:0] inst;
wire[4:0] add_o;
wire[7:0] op;
reg[7:0] prog[31:0];
pacessor p1(clk,rst_master,inst,add_o,op);
always #50 clk=~clk;
always @* begin
inst={prog[add_o],prog[add_o+1],prog[add_o+2],prog[add_o+3]};
end
initial begin
clk=0;
{prog[0],prog[1],prog[2],prog[3]}<=0;
{prog[4],prog[5],prog[6],prog[7]}<=0;
{prog[8],prog[9],prog[10],prog[11]}<=32'h07020500;
{prog[12],prog[13],prog[14],prog[15]}<=32'h07050600;
{prog[16],prog[17],prog[18],prog[19]}<=32'h08000200;
{prog[20],prog[21],prog[22],prog[23]}<=32'h08000500;
{prog[24],prog[25],prog[26],prog[27]}<=32'h01000502;
{prog[28],prog[29],prog[30],prog[31]}<=32'h02000502;
rst_master=1;
#200;
rst_master=0;
end
endmodule

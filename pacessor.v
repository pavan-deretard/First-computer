/*This is a single cycle single core processor designed by me.
This processor has ALu which has direct access only to the register bank.
The register bank consist of 16 registers with 2 parallel reads or 1 write in each cycle
the instructions are fed into the program memory which is the test bench of this simulation
the instruction is 32bit and has the following format
	32'habcdefgh
		ab=opcode
		cd=source address
		ef=operand 1
		gh=operand 2
	This processor has the following instructions in hexadecimal:
		arithematic:
		01-add
		02-sub
		03-and
		04-or
		05-xor
		06-not
		07-shift left
		08-shift right
		09-equality comparitor
		
		memory:
		10 load into register
		1f display contents of register
		
		branch:
		20 unconditional branch
		21 conditinal branch
		
*/
`timescale 1ns/1ns
module pacessor(input wire clk,rst_master, input wire[31:0] inst,output reg[5:0] add_o, output reg[7:0] op);

wire rst,rst_in;
or o(rst,rst_master,rst_in);

wire pc_inc,jmp,jmp_sig,jmp_sig_c,w_r;
wire[3:0] alu_inst;
wire[5:0] add;
wire[7:0] operand_1,operand_2,sol;
wire[5:0] jmp_add;
wire[1:0] op_sel;
wire[7:0] reg_data;
wire[3:0] w_add,r_add1,r_add2;
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
reg_bank rb(w_r,w_add,r_add1,r_add2,reg_data,operand_1[7:0],operand_2);
alu al(clk,alu_inst,operand_1,operand_2,sol);
decode dc(clk,sol,inst,w_r,rst_in,jmp_sig,jmp_sig_c,op_sel,jmp_add,alu_inst,reg_data,w_add,r_add1,r_add2);
control c(jmp_sig,jmp_sig_c,sol,jmp,pc_inc);
endmodule

module prog_mem();
reg clk,rst_master;
reg[31:0] inst;
wire[5:0] add_o;
wire[7:0] op;
reg[7:0] prog[63:0];
pacessor p1(clk,rst_master,inst,add_o,op);
always #10 clk=~clk;
always @* begin
inst={prog[add_o],prog[add_o+1],prog[add_o+2],prog[add_o+3]};
end
initial begin
clk=0;
{prog[0],prog[1],prog[2],prog[3]}<=32'h10000100;				//0   
{prog[4],prog[5],prog[6],prog[7]}<=32'h10010000;				//4 
{prog[8],prog[9],prog[10],prog[11]}<=32'h01010001;				//8
{prog[12],prog[13],prog[14],prog[15]}<=32'h20080002;			//12 
{prog[16],prog[17],prog[18],prog[19]}<=32'h10030300;			//16
{prog[20],prog[21],prog[22],prog[23]}<=32'h10040500;			//20	
{prog[24],prog[25],prog[26],prog[27]}<=32'h02040403;			//24
{prog[28],prog[29],prog[30],prog[31]}<=32'h1f000402;			//28
{prog[32],prog[33],prog[34],prog[35]}<=32'h09000004;			//32
{prog[36],prog[37],prog[38],prog[39]}<=32'h06000100;			//36
{prog[40],prog[41],prog[42],prog[43]}<=32'h07000100;			//40
{prog[44],prog[45],prog[46],prog[47]}<=32'h20100101;			//44
{prog[48],prog[49],prog[50],prog[51]}<=32'h00000101;			//48
{prog[52],prog[53],prog[54],prog[55]}<=32'h01000001;			//52
{prog[56],prog[57],prog[58],prog[59]}<=32'h00000100;			//56
{prog[60],prog[61],prog[62],prog[63]}<=32'h02000100;			//60
rst_master=1;
#20;
rst_master=0;
end
endmodule
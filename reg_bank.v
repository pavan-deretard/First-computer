`timescale 1ns/1ns
module reg_bank(input wire w_r, input wire[3:0] w_add,r_add_1,r_add_2, input wire[7:0] data,output reg[7:0] data_1,data_2);
reg[7:0] regs[0:15];
integer i;
initial begin

	for(i=0;i<16;i=i+1) begin
	regs[i]=0;
	end
end
always @* begin
	if(w_r) begin
		regs[w_add]<=data;
		data_1<=regs[r_add_1];
		data_2<=regs[r_add_2];
		end
	else if(!w_r) begin
		data_1<=regs[r_add_1];
		data_2<=regs[r_add_2];
		end
end
endmodule


module reg_bank_tb();
reg w_r;
reg[3:0] r_add_1,r_add_2,w_add;
reg[7:0] data;
wire[7:0] data_1,data_2;
reg_bank rb1(.w_r(w_r),.r_add_1(r_add_1),.r_add_2(r_add_2),.w_add(w_add),.data(data),.data_1(data_1),.data_2(data_2));
initial begin
w_r=1;
w_add=0;
data=10;
#10;
data=0;
w_r=0;
r_add_1=4'h0;
r_add_2=1;
#10;
w_r=1;
w_add=0;
data=8'ha9;
#50
w_r=0;
r_add_1=0;
r_add_2=1;
#10;
$finish();
end
endmodule
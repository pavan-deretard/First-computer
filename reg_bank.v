`timescale 1ns/1ns
module reg_bank(input wire w_r, input wire[3:0] w_add,r_add_1,r_add_2, input wire[7:0] data,output reg[7:0] data_1,data_2);
reg[7:0] regs[0:15];
always @* begin
if(w_r) begin
regs[w_add]<=data;
data_1<=8'bz;
data_2<=8'bz;
end
else if(!w_r) begin
data_1=regs[r_add_1];
data_2=regs[r_add_2];
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
w_add=10;
data=10;
$display("The value of data_1 after writing is %d", data_1);
#10;
//add_1=1;
//data=$random;
//#10;
//add_1=2;
//data=$random;
//#50;
$display("The value before loading is %d", data_1);
w_r=0;
r_add_1=4'ha;
r_add_2=1;
#10;
$display("The value of %d", data_1);
//add_1=1;
//add_2=2;
//#10;
//add_1=2;
//add_2=0;
//#10;
$finish();
end
endmodule

module decode (input wire[31:0] inst,
					output reg w_r,rst,pc_inc,jmp,
					output reg[1:0] op_sel,
					output reg[4:0] jmp_add,
					output reg[2:0] alu_inst,
					output reg[7:0] reg_data,
					output reg[3:0] w_add,r_add1,r_add2);
always @* begin
case(inst[31:24])
	default:begin
		w_r<=0;
		alu_inst<=0;
		rst<=0;
		pc_inc<=1;
		jmp<=0;
		jmp_add<=0;
		op_sel<=2'b00;
		w_add<=4'hx;
		r_add1<=4'hz;
		r_add2<=4'hz;
		reg_data<=8'hzz;
		end
	8'h01:begin
		w_r<=0;
		alu_inst<=1;
		rst<=0;
		pc_inc<=1;
		jmp<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;
		end
	8'h02:begin
		w_r<=0;
		alu_inst<=2;
		rst<=0;
		pc_inc<=1;
		jmp<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h07:begin
		w_r<=1;
		alu_inst<=0;
		rst<=0;
		pc_inc<=1;
		jmp<=0;
		jmp_add<=0;
		op_sel<=2'b00;
		w_add<=inst[19:16];
		r_add1<=4'hz;
		r_add2<=4'hz;
		reg_data<=inst[15:8];

		end
	8'h08:begin
		w_r<=0;
		alu_inst<=0;
		rst<=0;
		pc_inc<=1;
		jmp<=0;
		jmp_add<=0;
		op_sel<=2'b11;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;
		end
endcase
end
endmodule


module decode_tb();
reg[31:0] inst;
wire w_r,rst,pc_inc,jmp;
wire[4:0] jmp_add;
wire[2:0] alu_inst;
wire[1:0] op_select;
wire[7:0] reg_data;
wire[3:0] w_add,r_add1,r_add2;
decode dc(inst,w_r,rst,pc_inc,jmp,op_select,jmp_add,alu_inst,reg_data,w_add,r_add1,r_add2);
initial begin
inst=0;
#50
inst=32'h01000201;
#50
inst=32'h02000007;
#50
inst=32'h07050a01;
#50
inst=32'h08000900;
#50
$finish();

end
endmodule


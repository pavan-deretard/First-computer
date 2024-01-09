module decode (input wire[31:0] inst,
					output reg w_r,rst,jmp_sig,jmp_sig_c,
					output reg[1:0] op_sel,
					output reg[5:0] jmp_add,
					output reg[3:0] alu_inst,
					output reg[7:0] reg_data,
					output reg[3:0] w_add,r_add1,r_add2);
always @* begin
case(inst[31:24])
	default:begin
		w_r<=0;
		alu_inst<=0;
		rst<=0;	
		jmp_sig<=0;
		jmp_sig_c<=0;
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
		jmp_sig<=0;
		jmp_sig_c<=0;
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
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h03:begin
		w_r<=0;
		alu_inst<=3;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h04:begin
		w_r<=0;
		alu_inst<=4;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h05:begin
		w_r<=0;
		alu_inst<=5;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h06:begin
		w_r<=0;
		alu_inst<=6;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h07:begin
		w_r<=0;
		alu_inst<=7;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h08:begin
		w_r<=0;
		alu_inst<=8;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h09:begin
		w_r<=0;
		alu_inst<=9;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b10;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h10:begin
		w_r<=1;
		alu_inst<=0;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b00;
		w_add<=inst[19:16];
		r_add1<=4'hz;
		r_add2<=4'hz;
		reg_data<=inst[15:8];
	end
	8'h1f:begin
		w_r<=0;
		alu_inst<=0;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=0;
		jmp_add<=0;
		op_sel<=2'b11;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;
		end
	8'h20:begin
		w_r<=0;
		alu_inst<=0;
		rst<=0;
		jmp_sig<=1;
		jmp_sig_c<=0;
		jmp_add[5:0]<=inst[21:16];
		op_sel<=2'b00;
		w_add<=4'hx;
		r_add1<=inst[11:8];
		r_add2<=inst[3:0];
		reg_data<=8'hzz;

		end
	8'h21:begin
		w_r<=0;
		alu_inst<=9;
		rst<=0;
		jmp_sig<=0;
		jmp_sig_c<=1;
		jmp_add[5:0]<=inst[21:16];
		op_sel<=2'b00;
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
wire w_r,rst,pc_inc,jmp_sig,jmp_sig_c;
wire[4:0] jmp_add;
wire[2:0] alu_inst;
wire[1:0] op_select;
wire[7:0] reg_data;
wire[3:0] w_add,r_add1,r_add2;
decode dc(inst,w_r,rst,pc_inc,jmp_sig,jmp_sig_c,op_select,jmp_add,alu_inst,reg_data,w_add,r_add1,r_add2);
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


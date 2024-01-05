module decode (input wire[31:0] inst, output reg w_r,rst,pc_inc,jmp,output reg[1:0] op_sel,output reg[4:0] jmp_add, output reg[2:0] alu_inst);
always @* begin
case(inst[31:24])
	default:begin
		w_r=0;
		alu_inst=0;
		rst=0;
		pc_inc=1;
		jmp=0;
		jmp_add=0;
		op_sel=2'b00;
		end
	8'h01:begin
		w_r=0;
		alu_inst=1;
		rst=0;
		pc_inc=1;
		jmp=0;
		jmp_add=0;
		op_sel=2'b10;
		end
	8'h02:begin
		w_r=0;
		alu_inst=2;
		rst=0;
		pc_inc=1;
		jmp=0;
		jmp_add=0;
		op_sel=2'b10;
		end
	8'h07:begin
		w_r=1;
		alu_inst=0;
		rst=0;
		pc_inc=1;
		jmp=0;
		jmp_add=0;
		op_sel=2'b00;
		end
	8'h08:begin
		w_r=0;
		alu_inst=0;
		rst=0;
		pc_inc=1;
		jmp=0;
		jmp_add=0;
		op_sel=2'b11;
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
decode dc(inst,w_r,rst,pc_inc,jmp,op_select,jmp_add,alu_inst);
initial begin
inst=0;
#50
inst=32'h01000101;
#50
inst=32'h02000101;
#50
inst=32'h07000101;
#50
$finish();

end
endmodule


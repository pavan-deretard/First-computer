`timescale 1ns/1ns
module program_counter(input wire pc_inc,rst,clk,jmp, input	wire[4:0] jmp_add,	output reg[4:0] add);
always@(clk) begin
	if(clk) begin
	if(!rst) begin
		if(jmp) begin
		add <=jmp_add;
		end
		else if(pc_inc) begin
		add=add+4;
		end
	end

else begin
add=0;
end
end
end

endmodule

module pc_tb;
wire[4:0] add;
reg pc_inc,rst,clk,jmp;
reg[4:0] jmp_add;

program_counter pc1(pc_inc,rst,clk,jmp,jmp_add,add);
initial begin
clk=1;
	forever begin
		
		#50
		clk=~clk;
		end
end
initial begin
	
	rst=1;
	jmp=0;
	pc_inc=0;
	jmp_add=0;
	
	#100
	rst=0;
	pc_inc=1;
	#500
	jmp=1;
	jmp_add=34;
	#50;
	jmp=0;
	rst=1;
	#5000
	$finish();
end
endmodule

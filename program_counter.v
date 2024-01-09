`timescale 1ns/1ns
module program_counter(pc_inc,rst,clk,jmp,jmp_add,add);
input wire pc_inc,rst,clk,jmp;
input wire[5:0] jmp_add;
output reg[5:0] add;
always @(posedge clk,posedge rst) begin
    if (rst) begin
      add <= 0;
    end 
	 else if(clk) begin
      if (jmp) begin
        add <= jmp_add;
      end else if (pc_inc) begin
        add[5:0] <= add[5:0] + 6'h04;
      end
    end

  end

endmodule

module pc_tb();
reg pc_inc,rst,clk,jmp;
reg[5:0] jmp_add;
wire[5:0] add;

program_counter pc(pc_inc,rst,clk,jmp,jmp_add,add);

always #25 clk=~clk;

initial begin
clk=0;
rst=1;
#25
rst=0;
jmp=0;
jmp_add=0;
pc_inc=1;
#500
$finish();
end
endmodule
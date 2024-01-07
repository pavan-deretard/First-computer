`timescale 1ns/1ns
module program_counter(pc_inc,rst,clk,jmp,jmp_add,add);
input wire pc_inc,rst,clk,jmp;
input wire[4:0] jmp_add;
output reg[4:0] add;
always @(posedge clk,posedge jmp,posedge rst) begin
    if (rst) begin
      add <= 0;
    end 
	 else if(clk) begin
      if (jmp) begin
        add <= jmp_add;
      end else if (pc_inc) begin
        add <= add + 4;
      end
    end

  end

endmodule

module pc_tb();
reg pc_inc,rst,clk,jmp;
reg[4:0] jmp_add;
wire[4:0] add;

program_counter pc(pc_inc,rst,clk,jmp,jmp_add,add);

always #50 clk=~clk;

initial begin
clk=0;
rst=1;
pc_inc=$random;
jmp=$random;
jmp_add=$random;
#100;
rst=0;
pc_inc=1;
jmp=0;
jmp_add=$random;
#300
pc_inc=1;
jmp=$random;
jmp_add=$random;
#300;
pc_inc=0;
jmp=$random;
jmp_add=$random;
#300
#23
rst=1;
#40
$finish();
end
endmodule

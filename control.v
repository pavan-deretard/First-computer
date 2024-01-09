module control(jmp_sig,jmp_sig_c,sol,jmp,pc_inc);
input wire jmp_sig,jmp_sig_c;
input wire [7:0] sol;
output wire jmp,pc_inc;
wire a_in,z_t;
or o1(z_t,sol[0],sol[1],sol[2],sol[3],sol[4],sol[5],sol[6],sol[7]);
and a(a_in,jmp_sig_c,z_t);
or o2 (jmp,a_in,jmp_sig);
not n1(pc_inc,jmp);
endmodule

module con_tb();
wire jmp,pc_inc;
reg jmp_sig,jmp_sig_c;
reg[7:0] sol;
control c(jmp_sig,jmp_sig_c,sol,jmp,pc_inc);
initial begin
jmp_sig<=0;
jmp_sig_c<=0;
sol<=8'h01;
#10
jmp_sig_c<=1;
#10
sol<=8'h00;
#10
jmp_sig_c=0;
#10;
jmp_sig_c<=0;
sol<=4;
jmp_sig<=1;
#10;
end
endmodule

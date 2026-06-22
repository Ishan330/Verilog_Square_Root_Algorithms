// testbench
module lut_test;
reg [7:0] N;
wire [3:0] result;
LUT DUT(N,result);

initial 
begin
#5 N=25;
#5 N=49;
#5 N=81;
#5 N=169;
#5 N=224;
#5 N=225;
#5 N=0;
#5 $finish;
end

initial 
begin
$dumpfile("lut.vcd");
$dumpvars(0,lut_test);
$monitor ($time, " %d %d", N,result);
end

endmodule
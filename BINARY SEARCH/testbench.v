// testbench
module bs_test;
reg [7:0] data_in;
reg clk,start;
wire done;
datapath DP(clk,ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,eq,mid,n,low_sel,high_sel,data_in);
controller CT(start,clk,ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,eq,mid,n,low_sel,high_sel,done,low_gt_high);

initial 
begin
clk=1'b0;
#13 start=1'b1;
#500 $finish;
end

always 
#5 clk=~clk;

initial 
begin
$dumpfile("tb.vcd");
$dumpvars(0,bs_test);
$monitor($time,"%d %b",DP.M3,done);
end

initial 
begin
#3 data_in=144;
end

endmodule
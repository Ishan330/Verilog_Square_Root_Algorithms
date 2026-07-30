// datapath code
module datapath(clk,ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,eq,mid,n,low_sel,high_sel,data_in,low_gt_high);
input clk,ldLOW,ldHIGH,ldMID2,ldN,clrLOW,clrHIGH,clrMID2,clrN,low_sel,high_sel;
input [7:0] data_in;
output eq,mid,n;
output low_gt_high;
wire [7:0] L1,L2,H1,H2,M3,N;
wire [15:0] M1,M2;
PIPO_l_h LOW(clk,ldLOW,clrLOW,L2,L1);
PIPO_l_h HIGH(clk,ldHIGH,clrHIGH,H2,H1);
PIPO_mid2 MID2_reg(clk,ldMID2,clrMID2,M1,M2);
n_reg N_reg(clk,ldN,clrN,data_in,N);
comp COMP(M2,N,mid,n,eq);
mid2 MID2(L1,H1,M1,M3);
assign L2 = (low_sel)  ? (M3 + 1) : 8'b0;
assign H2 = (high_sel) ? (M3 - 1) : N;
assign low_gt_high = (L1 > H1);
endmodule

module n_reg(clk,ld,clr,in,out);
input [7:0] in;
input ld,clr,clk;
output reg [7:0] out;
always @(posedge clk)
begin
if(clr)
out<=8'b0;
else if(ld)
out<=in;
end
endmodule

module PIPO_l_h(clk,ld,clr,in,out);
input [7:0] in;
input ld,clr,clk;
output reg [7:0] out;
always @(posedge clk)
begin
if(clr)
out<=8'b0;
else if(ld)
out<=in;
end
endmodule

module PIPO_mid2(clk,ld,clr,in,out);
input [15:0] in;
input ld,clr,clk;
output reg [15:0] out;
always @(posedge clk)
begin
if(clr)
out<=16'b0;
else if(ld)
out<=in;
end
endmodule

module comp(data,N,mid,n,eq);
input [15:0] data;
input [7:0] N;
output mid,n,eq;
assign eq=(data=={8'b0,N});
assign mid=(data>{8'b0,N});
assign n=(data<{8'b0,N});
endmodule

module mid2(in1,in2,out,mid);
input [7:0] in1,in2;
output [7:0] mid;
output [15:0] out;
assign mid=(in1+in2)/2;
assign out=mid*mid;
endmodule

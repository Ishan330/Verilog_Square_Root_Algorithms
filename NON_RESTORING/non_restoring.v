// NON RESTORING SQUARE ROOT METHOD
module non_restoring_sqrt(clk,start,N,done,Q);
input clk,start;
input [7:0] N;
output reg done;
output reg [3:0] Q;
reg [8:0] R;
reg [2:0] count;
reg [7:0] N_reg;

reg [1:0] next_pair;
reg [8:0] trial;

always @(posedge clk)
begin
if(start)
begin
N_reg <= N;
R     <= 0;
Q     <= 0;
count <= 0;
done  <= 0;
end

else if(count < 4)
begin

        // Select next 2-bit group
case(count)
0: next_pair = N_reg[7:6];
1: next_pair = N_reg[5:4];
2: next_pair = N_reg[3:2];
3: next_pair = N_reg[1:0];
endcase

// Bring down next pair
R = (R << 2) | next_pair;

// Trial divisor = (Q << 2) + 1
trial = (Q << 2) | 1;

if(R >= trial)
begin
R = R - trial;
Q = (Q << 1) | 1;
end
else
begin
Q = (Q << 1);
end

count <= count + 1;

end

else
begin
done <= 1;
end

end

endmodule
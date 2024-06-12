`timescale 1 ns/10 ps

module tb;

reg clock, reset, en;
// reg [3:0] t;
wire [3:0] count;
// reg p;
wire pass;

localparam PERIOD = 10;

timer DUT(
    .en(en),
    .clock(clock),
    .reset(reset),
    .t_default(4'd5),
    .count(count),
    .pass(pass)
);

// Reset
initial
begin
    reset = 1'b1;
    #PERIOD
    reset = 1'b0;
end

// Clock
initial
begin
    clock = 1'b0;
   
    forever #(PERIOD/2) clock = ~clock;
end

initial
begin
    en = 1'b0;
    #PERIOD
    en = 1'b1;
    #PERIOD
    #PERIOD
    #PERIOD
    #PERIOD
    #PERIOD
    en = 1'b0;
    #PERIOD
    en = 1'b1;
    #PERIOD
    #PERIOD
    #PERIOD
    #PERIOD
    #PERIOD
    en = 1'b0;
end

endmodule
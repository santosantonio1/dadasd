`timescale 1 ns/1 ps

module tb;

reg clock, reset, door, ignicao;
wire [3:0] count;
wire alarme;

localparam PERIOD = 10;

top DUT(
    .clock(clock),
    .reset(reset),
    .door(door),
    .ignicao(ignicao),
    .alarme(alarme)
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
    door = 1'b0;
    #PERIOD
    door = 1'b1;
    #PERIOD
    door = 1'b0;
    #PERIOD
    #PERIOD
    door = 1'b1;
    #PERIOD
    door = 1'b0;
    #(8*PERIOD)
    door = 1'b1;
    #(8*PERIOD)
    door = 1'b0;
    #(4*PERIOD)
    door = 1'b1;
end

initial
begin
    ignicao = 1'b0;
    #(26*PERIOD)
    ignicao = 1'b1;
end

endmodule
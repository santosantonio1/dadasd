`timescale 1 ns/1 ps

module tb;

reg clock, reset, door, ignicao;
wire [3:0] count;
wire armar;

localparam PERIOD = 10;

driver DUT(
    .clock(clock),
    .reset(reset),
    .door(door),
    .ignicao(ignicao),
    .armar(armar)
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
end

initial
begin
    ignicao = 1'b0;
end

endmodule
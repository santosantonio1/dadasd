module arm(
    input clock, reset, ignicao, door,
    output alarme, desarmar
);

wire en, pass;
wire [3:0] count;
reg unlock;

always @(posedge clock, posedge reset, posedge ignicao)
begin
    if(reset)
        unlock <= 1'b0;
    else
        if(ignicao)
            unlock <= 1'b1;
        else
            unlock <= 1'b0;
end


timer T_ARM(
    .clock(clock),
    .reset(reset),
    .en(en),
    .t_default(4'd4),
    .pass(pass),
    .count(count)
);

assign desarmar = unlock;
assign alarme = pass;
assign en = (door && !ignicao) ? 1'b1 : 1'b0;

endmodule
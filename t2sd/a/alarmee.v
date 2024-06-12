`define IDLE 4'd0;
`define WAIT_IGNICAO 4'd1;
`define ACTIVATE 4'd2;
`define STOP 4'd3;

module alarmee(
    input clock, reset, ignicao, door,
    output alarme, desarmar
);

reg [3:0] EA, PE;
reg unlock;
wire [3:0] count;
wire en1, pass;

timer T_ALARM(
    .clock(clock),
    .reset(reset),
    .en(en1),
    .t_default(4'd6),
    .pass(),
    .count
);

timer T_ARM(
    .clock(clock),
    .reset(reset),
    .en(en2),
    .t_default(4'd4),
    .pass(),
    .count()
);

always @(posedge clock, posedge reset, posedge ignicao)
begin
    if(reset)
    begin
        EA <= `IDLE;
        unlock <= 1'b0;
    end
    else
        EA <= PE;
end

always @*
begin
    case(EA)
    
    `IDLE:
        if(door)
            PE <= `WAIT_IGNICAO;
        else
            PE <= `IDLE;
    
    `WAIT_IGNICAO:
        if(!door)
            PE <= `IDLE;
        else
            if()
    
    endcase
end

endmodule
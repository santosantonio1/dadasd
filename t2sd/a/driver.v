`define WAIT_DOOR_OPEN 4'd0
`define WAIT_DOOR_CLOSE 4'd1
`define WAIT_DOOR_TIMER 4'd2


// Tirar o ignicao?
module driver(
    input clock, reset, door, ignicao,
    output armar
);

reg [3:0] EA, PE;
wire en, pass;
wire [3:0] count;

timer T_DRIVER(
    .clock(clock),
    .reset(reset),
    .en(en),
    .t_default(4'd6),
    .count(count),
    .pass(pass)
);

// Troca de estados
always @(posedge clock, posedge reset)
begin
    if(reset)
    begin
        EA <= `WAIT_DOOR_OPEN;
    end
    else
    begin
        EA <= PE;
    end
end

// Definição das trocas de estado
always @*
begin
    case(EA)

    `WAIT_DOOR_OPEN:
    begin
        if(door)
            PE <= `WAIT_DOOR_CLOSE;
        else
            PE <= `WAIT_DOOR_OPEN;
    end
    `WAIT_DOOR_CLOSE:
    begin
        if(!door)
            PE <= `WAIT_DOOR_TIMER;
        else
            PE <= `WAIT_DOOR_CLOSE;
    end
    `WAIT_DOOR_TIMER:
    begin
        if(door)
            PE <= `WAIT_DOOR_CLOSE;
        else
            if(pass)
                PE <= `WAIT_DOOR_OPEN;
            else
                PE <= `WAIT_DOOR_TIMER;
    end    

    default: PE <= `WAIT_DOOR_OPEN;

    endcase
end

// Começar a contagem regressiva...
assign en = (EA == `WAIT_DOOR_TIMER && !ignicao) ? 1'b1 : 1'b0;
// Sinalizar que o sistema está armado...
assign armar = pass;

endmodule
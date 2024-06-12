`define ARMADO 4'd0
`define DESARMADO 4'd1
`define ACIONAR 4'd2
`define ACIONADO 4'd3

module top(
    input clock, reset, ignicao, door,
    output alarme
);

reg [3:0] EA, PE;
reg stop_alarm;
// reg desarmar;
wire armar, desarmar, waited_alarm_on, alrm;
wire [3:0] count;

// Troca de estados e inicialização do sistema
always @(posedge clock, posedge reset)
begin
    if(reset)
    begin
        EA <= `DESARMADO;
        // desarmar <= 1'b0;
        stop_alarm <= 1'b0;
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
        `DESARMADO:
            if(armar && !ignicao)
                PE <= `ARMADO;
            else 
                PE <= `DESARMADO;

        `ARMADO:
            if(door)
                PE <= `ACIONAR;
            else
                PE <= `ARMADO;
        
        `ACIONAR:
            if(desarmar)
                PE <= `DESARMADO;
            else
                if(alarme)
                    PE <= `ACIONADO;
                else
                    PE <= `ACIONAR;
            
        `ACIONADO:
            if(ignicao)
                PE <= `DESARMADO;
            else
                if(!door && waited_alarm_on)
                    PE <= `ACIONAR;
                else
                    PE <= `ACIONADO;            
        
        // `ARMADO:
        //     if(desarmar)
        //         PE <= `DESARMADO;
        //     else
        //         if(alarme)
        //             PE <= `ACIONAR;
        //         else
        //             PE <= `ARMADO;

        default : PE <= `DESARMADO;
    endcase
end

driver d1(
    .clock(clock),
    .reset(reset),
    .door(door),
    .ignicao(ignicao),
    .armar(armar)
);

arm d2(
    .clock(clock),
    .reset(reset),
    .door(door),
    .ignicao(ignicao),
    .alarme(alrm),
    .desarmar(desarmar)
);

// Alarme ativado por x tempo após fechar a porta e n ligar o carro
always @(posedge clock, negedge door)
begin
    if(!door && !ignicao)
        stop_alarm <= 1'b1;
    else
        if(waited_alarm_on || ignicao)
            stop_alarm <= 1'b0; 
            
end

timer T_ALARM(
    .clock(clock),
    .reset(reset),
    .en(stop_alarm),
    .t_default(4'd3),
    .count(count),
    .pass(waited_alarm_on)
);

assign alarme = alrm;

endmodule
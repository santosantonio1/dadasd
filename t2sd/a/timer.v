module timer(
    input clock, reset, en,
    input [3:0] t_default,
    output [3:0] count,
    output pass
);

reg [3:0] t;
reg p;

// always @(posedge clock, posedge reset, posedge en)
// begin
//     if(reset)
//     begin
//         t <= 4'd0;
//         p <= 1'b0;
//     end
//     else
//     // if(en)
//     // begin
//         if(t < t_default)
//         begin
//             t <= t + 4'd1;
//             if(t == t_default)
//                 p <= 1'b1;
//         end
//     // end
//     else
//     begin
//         t <= 4'd0;
//         p <= 1'b0;
//     end
// end

always @(posedge clock, posedge reset, posedge en)
begin
    if(reset)
    begin
        t <= 4'd0;
        p <= 1'b0;
    end
    else
    if(en)
    begin
        if(t < t_default-1)
        begin
            t <= t + 4'd1;
        end
        else
        begin
            p <= 1'b1;
        end
    end
    else
    begin
        t <= 4'd0;
        p <= 1'b0;
    end
end

assign count = t;
assign pass = p;

endmodule
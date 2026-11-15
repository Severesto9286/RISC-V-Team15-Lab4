module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        alu_ctrl,
    output logic [31:0] result,
    output logic        EQ
);


    always_comb begin
        if (alu_ctrl == 0)
            result = a + b;

        else
            result = a - b;
    end
    assign EQ = (result == 0);

endmodule
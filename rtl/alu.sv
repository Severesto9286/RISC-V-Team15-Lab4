module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        alu_op,
    output logic [31:0] result,
    output logic        zero
);


    always_comb begin
        if (alu_op == 0)
            result = a + b;

        else
            result = a - b;
    end
    assign zero = (result == 0);

endmodule
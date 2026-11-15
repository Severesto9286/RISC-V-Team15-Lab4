module control_unit(
    input logic [6:0] opcode,
    input logic EQ,
    output logic RegWrite, ALUctrl, ALUsrc, ImmSrc, PCsrc
);

always_comb begin
    case(opcode)
        7'b0010011: begin
            RegWrite = 1;
            ALUctrl = 0;
            ImmSrc = 0;
            ALUsrc = 1;
            PCsrc = 0;
        end
        7'b1100011: begin
            RegWrite = 0;
            ALUctrl = 1;
            ImmSrc = 1;
            ALUsrc = 0;
            PCsrc = 1;
        end
    endcase
end
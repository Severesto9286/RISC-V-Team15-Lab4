module regfile(
    input logic     clk,
    input logic     RegWrite,
    input logic [4:0]  rs1,
    input logic [4:0]  rs2,
    input logic [4:0]  rd,
    input  logic [31:0] write_data,

    output logic [31:0] read_data1,
    output logic [31:0] read_data2,
    output logic [31:0] a0
);

logic [31:0] registers [0:31];

//assign output_signal = condition ? value_if_true : value_if_false;
assign read_data1 = (rs1 == 5'd0) ? 32'd0 : registers[rs1];
assign read_data2 = (rs2 == 5'd0) ? 32'd0 : registers[rs2];

assign a0 = registers[10];


always_ff @(posedge clk) begin
    if (RegWrite && rd != 5'b0) //write is 1 and inpout not 0
        registers[rd] <= write_data;
end

endmodule

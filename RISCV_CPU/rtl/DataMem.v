module data_memory (
    input wire clk,
    input wire reset,
    input wire MemRead,
    input wire MemWrite,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);

    // 4kb data mem (1024 words × 32 bits = 4096 bytes)
    reg [31:0] memory [0:1023];
    integer i;
    assign read_data = (MemRead)? memory[address[11:2]]: 32'b0;

    always @(posedge clk) begin
        if (reset) begin
            // clr memory
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end
        else begin

            if (MemWrite) begin
                // store word
                memory[address[11:2]] <= write_data;
            end
        end
    end
endmodule
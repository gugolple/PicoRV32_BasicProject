`timescale 1 ns / 1 ps

module system (
	input            clk,
	input            resetn,
	output           trap,
	output reg [7:0] out_byte,
	output reg       out_byte_en,
	// Output
	output reg [7:0] uart_dout,
	output reg       uart_dout_ctr,
	input            uart_dout_rdy,
	// UART IN
	input [7:0]      uart_din,
	input            uart_din_vld
);
	// 4096 32bit words = 16kB memory
	parameter MEM_SIZE = 4096;

	wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	reg [31:0] mem_rdata;

	wire mem_la_read;
	wire mem_la_write;
	wire [31:0] mem_la_addr;
	wire [31:0] mem_la_wdata;
	wire [3:0] mem_la_wstrb;

	picorv32 picorv32_core (
		.clk         (clk         ),
		.resetn      (resetn      ),
		.trap        (trap        ),
		.mem_valid   (mem_valid   ),
		.mem_instr   (mem_instr   ),
		.mem_ready   (mem_ready   ),
		.mem_addr    (mem_addr    ),
		.mem_wdata   (mem_wdata   ),
		.mem_wstrb   (mem_wstrb   ),
		.mem_rdata   (mem_rdata   ),
		.mem_la_read (mem_la_read ),
		.mem_la_write(mem_la_write),
		.mem_la_addr (mem_la_addr ),
		.mem_la_wdata(mem_la_wdata),
		.mem_la_wstrb(mem_la_wstrb)
	);
    
    // Request the memmory block
	reg [31:0] memory [0:MEM_SIZE-1];
	// LOAD IT FROM A HEX DIRECTLY, I LOVE THIS LINE!
	initial $readmemh("firmware.hex", memory);

	reg [31:0] m_read_data;
	reg m_read_en;

	generate
	   begin
		always @(posedge clk) begin
	       // ASYNC reset of the uart transmision for not retransmitting until
	       // next write FROM cpu. This is only due to CPU SLOWER THAN UART.
	        if (mem_instr) begin
	           uart_dout_ctr <= 0;
	        end
		    
		    // Normal memory behaviour when accessing RAM
			mem_ready <= 1;
			out_byte_en <= 0;
			if ((mem_la_addr >> 2) < MEM_SIZE) begin
                mem_rdata <= memory[mem_la_addr >> 2];
                if (mem_la_write) begin
                    if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
                    if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
                    if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
                    if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
                end
            end
            // Basic output register
			if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
				out_byte_en <= 1;
				out_byte <= mem_la_wdata;
			end
			// UART OUT!
			if (mem_la_write && mem_la_addr == 32'h1000_0004) begin
				if (mem_la_wstrb[0] && uart_dout_ctr == 0) begin
				    uart_dout[ 7: 0] <= mem_la_wdata[ 7: 0];
				    // Signal UART that data is valid
				    uart_dout_ctr <= 1;
				end
			end
			// UART IN!
			if (!mem_la_write && mem_la_addr == 32'h1000_0004) begin
			    mem_rdata[ 7: 0] <= uart_din[ 7: 0];
				mem_rdata[ 8] <= uart_din_vld;
				mem_rdata[ 9] <= uart_dout_rdy;
			end
		end
	end endgenerate
endmodule

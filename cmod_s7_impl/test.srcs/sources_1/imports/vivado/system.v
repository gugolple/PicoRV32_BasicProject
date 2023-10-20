`timescale 1 ns / 1 ps

module system (
	input            clk,
	input            resetn,
	output           trap,
	output reg [7:0] out_byte,
	output reg       out_byte_en,
	// Output
	output reg [7:0] uart_dout,
	output reg       uart_dout_vld,
	input            uart_dout_rdy,
	// UART IN
	input [7:0]      uart_din,
	input            uart_din_vld
);
	// 4096 32bit words = 16kB memory
	parameter MEM_SIZE = 4096;
	reg transmit_uart = 0;

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

	reg [31:0] memory [0:MEM_SIZE-1];
	initial $readmemh("firmware.hex", memory);

	reg [31:0] m_read_data;
	reg m_read_en;

	generate
	   begin
		always @(posedge clk) begin
		    if (uart_dout_vld && transmit_uart && !uart_dout_rdy) begin
		        transmit_uart <= 0;
		        uart_dout_vld <= 0;
		    end
		    if (transmit_uart && uart_dout_rdy) begin
		        uart_dout_vld <= 1;
		    end
			mem_ready <= 1;
			out_byte_en <= 0;
			mem_rdata <= memory[mem_la_addr >> 2];
			if (mem_la_write && (mem_la_addr >> 2) < MEM_SIZE) begin
				if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
				if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
				if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
				if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
			end
			else
			if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
				out_byte_en <= 1;
				out_byte <= mem_la_wdata;
			end
			// UART OUT!
			if (mem_la_write && mem_la_addr == 32'h1000_0001) begin
				if (mem_la_wstrb[0]) begin
				    uart_dout[ 7: 0] <= mem_la_wdata[ 7: 0];
				    transmit_uart <= 1;
				end
			end
			// UART IN!
			if (!mem_la_write && mem_la_addr == 32'h1000_0001) begin
			    m_read_data[ 7: 0] <= uart_din[ 7: 0];
				m_read_data[ 8] <= uart_din_vld;
				m_read_data[ 9] <= uart_dout_rdy;
			end
		end
	end endgenerate
endmodule

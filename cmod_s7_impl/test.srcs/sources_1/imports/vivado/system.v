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
	input            uart_din_vld,
	// IRQ
	input [31:0]     irq,
	output [31:0]    eoi
);
	// 4096 32bit words = 32kB memory
	parameter MEM_SIZE = 4096;

	wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	wire [31:0] mem_rdata;

	wire mem_la_read;
	wire mem_la_write;
	wire [31:0] mem_la_addr;
	wire [31:0] mem_la_wdata;
	wire [3:0] mem_la_wstrb;

	picorv32
	   #( .ENABLE_IRQ(1) ) 
	   picorv32_core (
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
		.mem_la_wstrb(mem_la_wstrb),
		.irq         (irq),
		.eoi         (eoi)
	);
	
    // Request the memmory block
	reg [31:0] memory [MEM_SIZE-1:0];
	// LOAD IT FROM A HEX DIRECTLY, I LOVE THIS LINE!
	initial $readmemh("firmware.hex", memory);
	
    // This logic block defines a RAM behaviour, MUST be handled independently.
    reg [31:0] mem_la_rdata_ram;
    reg out_byte_en_ram;
	
	// Extra IO functionality
	reg [31:0] mem_la_rdata_io;
	reg out_byte_en_io;
	
	generate
	   begin
	       // This awlays block DEFINES a RAM unit. DO NOT ADD TO IT.
           always @(posedge clk) begin
                // Normal memory behaviour when accessing RAM
                mem_ready <= 1;
                out_byte_en_ram <= 0;
                if ((mem_la_addr >> 2) < MEM_SIZE) begin
                    mem_la_rdata_ram <= memory[mem_la_addr >> 2];
                    if (mem_la_write) begin
                        if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
                        if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
                        if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
                        if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
                    end
                end else begin
                    mem_la_rdata_ram <= 32'b0;
                end
            end
	
            always @(posedge clk) begin
                mem_ready <= 1;
                // Basic output register
                if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
                    out_byte_en_io <= 1;
                    out_byte <= mem_la_wdata;
                // UART REG!
                end else if (mem_la_addr == 32'h1000_0004) begin
                    // UART OUT!
                    if (mem_la_write) begin
                        if (mem_la_wstrb[0] && uart_dout_ctr == 0) begin
                            uart_dout[ 7: 0] <= mem_la_wdata[ 7: 0];
                            // Signal UART that data is valid
                            uart_dout_ctr <= 1;
                        end
                    // UART IN!
                    end else begin
                        mem_la_rdata_io[ 7: 0] <= uart_din[ 7: 0];
                        mem_la_rdata_io[ 8] <= uart_din_vld;
                        mem_la_rdata_io[ 9] <= uart_dout_rdy;
                    end
                // Set to 0 when not in use to use OR to capture the values.
                end else begin
                    uart_dout_ctr <= 0;
                    out_byte_en_io <= 0;
                    mem_la_rdata_io <= 32'h00000000;
                end
                
                // Concentrate OUT_BYTE_EN
                out_byte_en <= out_byte_en_ram | out_byte_en_io;
            end
        end
	endgenerate
	
	// This is a wire to remove 1 latch in the transmission.
	// The latch is handled at the different sources.
	assign mem_rdata = mem_la_rdata_ram | mem_la_rdata_io;
endmodule

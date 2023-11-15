`timescale 1 ns / 1 ps

module system (
    input            sys_clk,
    input            clk,
    input            resetn,
    output reg [7:0] out_byte,
    output reg       out_byte_en,
    output reg       external_read,
    // UART
    input            uart_in,
    output           uart_out,
    // IRQ
    input [31:0]     irq,
    output [31:0]    eoi,
    // Led vector
    output [6:0]     led_vect
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

    // All IRQ related control
    `define IRQ_UART 4
    // Set all the IRQ signals, to 0 to prevent them from activating
    assign irq[31:`IRQ_UART+1] = {1'b0};
    // Signal 4 is set to IRQ_UAR
    assign irq[`IRQ_UART-1:0] = {1'b0};
    
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


    // Uart module!
    wire uart_enable;
    wire [31: 0] uart_output;
    wire uart_irq;
    cpu_uart uart_inst (
        .clk(sys_clk),
        .cpu_clk(clk),
        .reset(!resetn),
    // Generic due to being connected to MAIN CPU BUS
        .enable(uart_enable),
        .mem_write(mem_la_write),
        .mem_read(mem_la_read),
        .mem_wdata(mem_la_wdata),    // Full 32 bit write
        .mem_wstrb(mem_la_wstrb),    // Which bytes are enabled
        .mem_rdata(uart_output),     // Full 32 bit read
    // Generic due to interrupting CPU
        .irq(uart_irq),
        .eoi(eoi[`IRQ_UART]),
    // Uart specifics
        .uart_in(uart_in),
        .uart_out(uart_out)
    );
    assign irq[`IRQ_UART] = uart_irq;
    
    generate begin
       // This awlays block DEFINES a RAM unit. DO NOT ADD TO IT.
       always @(posedge clk) begin
            // Normal memory behaviour when accessing RAM
            mem_ready <= 1;
            if ((mem_la_addr >> 2) < MEM_SIZE) begin
                mem_la_rdata_ram <= memory[mem_la_addr >> 2];
                if (mem_la_write) begin
                    if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
                    if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
                    if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
                    if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
                end
            end else begin
                mem_la_rdata_ram <= 32'h0000_0000;
            end
        end

        // Block solving special registers
        always @(posedge clk) begin
            mem_ready <= 1;
            // Basic output register
            if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
                out_byte_en_io <= 1;
                out_byte <= mem_la_wdata;
            end else begin
                out_byte_en_io <= 0;
            end
            // Concentrate OUT_BYTE_EN
            out_byte_en <= out_byte_en_io;
        end
    end endgenerate
    
    // UART REG!
    assign uart_enable = mem_la_addr == 32'h1000_0004;
  
    
    // This is a wire to remove 1 latch in the transmission.
    // The latch is handled at the different sources.
    assign mem_rdata = mem_la_rdata_ram | uart_output;
    
    assign led_vect = {out_byte[6:0]};
endmodule

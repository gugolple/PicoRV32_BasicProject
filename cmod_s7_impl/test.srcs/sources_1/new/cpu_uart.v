module cpu_uart (
    input                 clk,
    input                 cpu_clk,
    input                 reset,
    // Generic due to being connected to MAIN CPU BUS
    input                 enable,
    input                 mem_write,
    input                 mem_read,
    input      [31: 0]    mem_wdata,    // Full 32 bit write
    input      [ 3: 0]    mem_wstrb,    // Which bytes are enabled
    output     [31: 0]    mem_rdata,    // Full 32 bit read
    // Generic due to interrupting CPU
    output                irq,
    input                 eoi,
    // Uart specifics
    input                 uart_in,
    output                uart_out
);
    // INTO THE UART, SO OUT FOR US
    reg [7:0] dout_uart;
    reg dout_vld;
    wire dout_rdy;
    // FROM THE UART, SO IN FOR US
    wire [7:0] din_uart;
    reg [7:0] din_uart_reg;
    wire din_vld;

    uart #(
        .CLK_FREQ(12_000_000),
        .BAUD_RATE(115200)
    )  uart_mod (
        // Basic
        .CLK (clk),
        .RST (reset),
        // Ports
        .UART_TXD (uart_out),
        .UART_RXD (uart_in),
        // Input for the module, output for us
        .DIN(dout_uart),
        .DIN_VLD(dout_vld),
        .DIN_RDY(dout_rdy),
        // Output for the module, input for us
        .DOUT(din_uart),
        .DOUT_VLD(din_vld)
    );
    
    // The following block manages to do a single transmission of the UART
    // module
    //Rising edge detector stores
    reg dout_rdy_dly;
    reg mem_write_dly;
    // Rising edge detector logic
    wire mem_write_pos = mem_write && !mem_write_dly;
    wire dout_rdy_neg = !dout_rdy && dout_rdy_dly;
    // Single triggering of UART communication logic.
    always @(posedge clk) begin
        // First accommodate the reset
        if (reset) begin
            dout_vld <= 0;
        // When CPU wants to transmit, we set dout_vld to start a transmission.
        end else if (enable && mem_write_pos && !dout_vld) begin
            dout_uart[ 7: 0] <= mem_wdata[ 7: 0];
            // Signal UART that data is valid
            dout_vld <= 1;
        // After we wait until dout_rdy goes negative to stop the signal.
        // This is done to accomodate 2 clock domains working.
        // MUST be done within one logic block, this tells the compiler that
        // it is one single state machine that we want to control.
        end else if (dout_rdy_neg) begin
            dout_vld <= 0;
        end
        // Rising edge detector delayers  
        dout_rdy_dly <= dout_rdy;
        mem_write_dly <= mem_write;
    end
  
    // The following block manages the reception of a single transmission of the
    // UART module
    // This module shall be at least 1 CPU clock cycle high to assert the IRQ
    // Rising edge detector and keeper, for the UART reception to comply with IRQ
    reg uart_datain_interruption_ctr;
    reg uart_datain_interruption_rq;
    reg [1:0] uart_datain_interruption_inter;
    // Rising edge detector
    reg din_vld_old;
    wire r_din_vld = din_vld && !din_vld_old;
    always @(posedge clk) begin
        // First accept the reset
        if (reset) begin
            uart_datain_interruption_ctr <= 0;
            uart_datain_interruption_inter <= 0;
            uart_datain_interruption_rq <= 0;
        // Will trigger when data is received
        end else if (r_din_vld && !eoi && !uart_datain_interruption_rq) begin
            uart_datain_interruption_ctr <= 1; 
            uart_datain_interruption_inter <= 1;
            uart_datain_interruption_rq <= 1;
        // Will wait until next LOW of CPU clock, will set IRQ and keep it HIGH until a full clock cycle.
        end else if (!cpu_clk && uart_datain_interruption_inter == 1) begin
            uart_datain_interruption_inter <= 2;
        end else if (cpu_clk & uart_datain_interruption_inter == 2) begin
            uart_datain_interruption_inter <= 3;
        end else if (!cpu_clk & uart_datain_interruption_inter == 3) begin
            uart_datain_interruption_inter <= 0;
            uart_datain_interruption_ctr <= 0;
        end else if (eoi && uart_datain_interruption_rq) begin
            uart_datain_interruption_rq <= 0;
        end
        din_vld_old <= din_vld;
    end

    // Set the IRQ if data has been received
    assign irq = uart_datain_interruption_ctr;

    // Buffer the read of the UART
    always @(posedge din_vld) begin
        din_uart_reg <= din_uart;
    end

    // Accommodate the CPU READ
    reg [31: 0] rdata;
    always @(posedge clk) begin
        // If it is our turn, write the buffered data
        if (enable) begin
            rdata[ 7: 0] <= din_uart_reg[ 7: 0];
            // Currently unused, bit for flags regarding the read status.
            rdata[ 8] <= 0;
            rdata[ 9] <= dout_rdy;
        // Otherwise set all to 0, allowing OR of all different modules
        end else begin
            rdata <= 32'h 0000_0000;
        end
    end
    assign mem_rdata = rdata;
endmodule

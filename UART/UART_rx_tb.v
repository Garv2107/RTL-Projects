`timescale 1ns/1ps

module UART_rx_tb();
    reg clk, rst, baud_tick, rx;
    wire rx_done, busy;
    wire [7:0]data_out;
    reg [7:0]data_in;
    reg [9:0]tx_frame; //BITS BEING TRANSMITTED OVER UART line
    integer i;
    
    UART_rx dut(.clk(clk), .rst(rst), .baud_tick(baud_tick), .rx(rx), .rx_done(rx_done), .busy(busy), .data_out(data_out));
    
    
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        baud_tick = 0;
        rx = 1;     //UART LINE IS IDLE
        
        #20 rst = 0;
        data_in = 8'hB1; //Transmitted BIT 8`hB1
            
        tx_frame[0] = 0; //start
        for(i = 0; i < 8; i = i + 1)begin
            tx_frame[i + 1] = data_in[i];
        end
        tx_frame[9] = 1; //STOP bit
        #1;
        
        for(i = 0; i < 10; i = i + 1)begin
            rx = tx_frame[i];
            @(posedge clk);
            #1;
            baud_tick = 1;
            @(posedge clk)
            #1;
            baud_tick = 0;
            
            @(posedge clk);
            @(posedge clk);
        end
        @(posedge clk);
        #1;
        
        // Extra baud tick for STOP state
        @(posedge clk);
        baud_tick = 1;

        @(posedge clk);
        baud_tick = 0;

        @(posedge clk);
        
        $display("shift_reg = %h", dut.shift_reg);
        $display("data_out  = %h", data_out);   
        
        if(data_out == data_in)
            $display("PASS : Data Received Correctly");
        else
            $display("FAIL : Expected %h, Got %h", data_in, data_out);
            
        if(!busy)
            $display("PASS : Not busy");
        else
            $display("FAIL : busy still asserted");

        #20 $finish;
    end
endmodule
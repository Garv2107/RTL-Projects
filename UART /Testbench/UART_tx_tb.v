`timescale 1ns/1ps

module UART_tx_tb();
reg clk, rst, baud_tick, tx_start;
reg [7:0]data_in;

wire tx, busy, done;
reg expected_data[0:9];
integer i;

UART_tx dut(.clk(clk), .rst(rst), .baud_tick(baud_tick), .tx_start(tx_start), .data_in(data_in), .tx(tx), .done(done), .busy(busy));

always #5 clk = ~clk;
initial begin
        
    clk = 0;
    rst = 1;
    baud_tick = 0;
    tx_start = 0;
    data_in = 0;
    
    #20 rst = 0;
    data_in = 8'hBC;
    tx_start = 1;
    
    @(posedge clk);
    #1
    if(busy)
        $display("Busy Flag Generated");
    else
        $display("Busy Flag Not Generated");
            
    @(posedge clk);
    tx_start = 0;
    
    //Declaring Expected Data Array
    expected_data[0] = 0; //START
    for(i = 0; i < 8; i = i + 1)begin
        expected_data[i+1] = data_in[i];
    end
    expected_data[9] = 1; //STOP
    
    for(i = 0;i < 10; i = i + 1)begin
           baud_tick = 1;
           @(posedge clk)
           baud_tick = 0;
           
         #1  
         $display("Expected=%b  TX=%b", expected_data[i], tx);
            if(tx == expected_data[i])
                $display("PASS : Bit %0d", i);
             else
                 $display("FAIL : Bit %0d", i);  
              
             if(done)
                $display("Done Flag Activated");              
        
        @(posedge clk);
    end
    #20 $finish;
end
endmodule
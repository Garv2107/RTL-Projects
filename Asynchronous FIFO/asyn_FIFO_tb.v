    `timescale 1ns/1ps
    
    module asyn_FIFO_tb();
        reg wr_en, rd_en, rst, wr_clk, rd_clk;
        reg [7:0]data_in;
        
        wire full, empty;
        wire [7:0]data_out;
        
        asyn_FIFO#(
        .DATA_WIDTH(8),
        .DEPTH(64),
        .ADDR_WIDTH(6)
                  ) dut(wr_en, rd_en, data_in, data_out, wr_clk, rd_clk, full, empty, rst);
         
         always #5 wr_clk = ~wr_clk;
         always #8 rd_clk = ~rd_clk; 
         integer i;
            
              
         initial begin
            wr_clk = 0;
            rd_clk = 0;
            rst = 1;
            data_in = 0;
            wr_en = 0;
            rd_en = 0;
            
            #30 rst = 0;
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle
              
             wr_en = 1;        //Writes AA
             data_in = 8'hAA;
             @(posedge wr_clk);
                wr_en = 0;   
                
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle
            
            wr_en = 1;
             data_in = 8'hBC;   //Writes BC
             @(posedge wr_clk);
                wr_en = 0;
                
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle   
            
            wr_en = 1;         
            rd_en = 1;         //Reads AA
            data_in = 8'h67;   //Writes 67
            @(posedge wr_clk);
                wr_en = 0;
            @(posedge rd_clk);
            #1
                rd_en = 0;
                if(data_out == 8'hAA)
                     $display("PASS : Read AA");
                else
                     $display("FAIL : Expected AA, Got %h", data_out);
            
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle  
            
            rd_en = 1;         //Reads BC 
            @(posedge rd_clk);
            #1
                rd_en = 0;
                if(data_out == 8'hBC)
                    $display("PASS : Read BC");
                else
                    $display("FAIL : Expected BC, Got %h", data_out);
                
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle
            
            rd_en = 1;         //Reads 67
            @(posedge rd_clk);
            #1
                rd_en = 0;
                if(data_out == 8'h67)
                    $display("PASS : Read 67");
                else
                    $display("FAIL : Expected 67, Got %h", data_out);
                
            repeat(2)@(posedge wr_clk); //Wait 2 clk cycle
            
             rd_en = 1;         //Activates Empty Flag
            @(posedge rd_clk);
            #1
                rd_en = 0;
                if(empty)
                    $display("PASS : FIFO Empty");
                else
                    $display("FAIL : Empty flag not asserted"); 
                 
               rst = 1;     
              repeat(3) @(posedge wr_clk);
              rst = 0;
              
              // Full Flag Activation      
             for(i = 0; i < 64; i = i + 1)begin
                data_in = i;
                wr_en = 1;
                @(posedge wr_clk)
                    wr_en = 0;
                
                @(posedge wr_clk);  //Wait 1 clk cycle    
             end  
              
             @(posedge wr_clk);  //Wait 1 clk cycle
             
             $display("Writes = %0d Reads = %0d Occupancy = %0d",
             dut.wr_ptr_bin,
             dut.rd_ptr_bin,
             dut.wr_ptr_bin - dut.rd_ptr_bin);
             
             if(full)
                $display("PASS : FIFO Full");
             else
                $display("FAIL : Full flag not asserted");
               
               //Extra Write added 
              data_in = 8'hAA;
              wr_en = 1;
    
              @(posedge wr_clk);
              wr_en = 0;  
              
              if(full)
                $display("PASS : Extra write blocked");
              else
                $display("FAIL : Full flag deasserted unexpectedly");
              #20 $finish;  
         end    
    endmodule

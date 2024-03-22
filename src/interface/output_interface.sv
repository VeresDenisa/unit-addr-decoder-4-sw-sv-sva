import item_pack::*;

interface output_interface(input bit clock);
    bit [7:0] rd_data_in;
    bit [5:0] ack_in;
    bit [5:0] sel_en_out;
    bit       wr_rd_d_out;
    bit [7:0] addr_out;
    bit [7:0] wr_data_out;

    clocking driver@(posedge clock);
        output rd_data_in;
        output ack_in;
    endclocking

    clocking monitor@(posedge clock);
        input rd_data_in;
        input ack_in;
        input sel_en_out;
        input wr_rd_d_out;
        input addr_out;
        input wr_data_out;
    endclocking

    task send(output_item t);
        @(driver);
        driver.rd_data_in <= t.rd_data_in;
        driver.ack_in     <= t.ack_in;
    endtask : send

    function automatic void receive(ref output_item t);
        t.rd_data_in  = monitor.rd_data_in;
        t.ack_in      = monitor.ack_in;
        t.sel_en_out  = monitor.sel_en_out;
        t.wr_rd_d_out = monitor.wr_rd_d_out;
        t.addr_out    = monitor.addr_out;
        t.wr_data_out = monitor.wr_data_out;
    endfunction
endinterface : output_interface
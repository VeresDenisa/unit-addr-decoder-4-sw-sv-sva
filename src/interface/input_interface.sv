import item_pack::*;

interface input_interface(input bit clock);
    bit       enable_in;
    bit       wr_rd_op;
    bit       valid_in;
    bit [7:0] addr_in;
    bit [7:0] op_in_id;
    bit [7:0] wr_data_in;
    bit       ready_out;
    bit [7:0] rd_data_out;
    bit [7:0] done_op_id;

    clocking driver@(posedge clock);
        output enable_in;
        output wr_rd_op;
        output valid_in;
        output addr_in;
        output op_in_id;
        output wr_data_in;
    endclocking

    clocking monitor@(posedge clock);
        input enable_in;
        input wr_rd_op;
        input valid_in;
        input addr_in;
        input op_in_id;
        input wr_data_in;
        input ready_out;
        input rd_data_out;
        input done_op_id;
    endclocking

    task send(input_item t);
        @(driver);
        driver.enable_in  <= t.enable_in;
        driver.wr_rd_op   <= t.wr_rd_op;
        driver.valid_in   <= t.valid_in;
        driver.addr_in    <= t.addr_in;
        driver.op_in_id   <= t.op_in_id;
        driver.wr_data_in <= t.wr_data_in;
    endtask : send

    function automatic void receive(ref input_item t);
        t.enable_in   = monitor.enable_in;
        t.wr_rd_op    = monitor.wr_rd_op;
        t.valid_in    = monitor.valid_in;
        t.addr_in     = monitor.addr_in;
        t.op_in_id    = monitor.op_in_id;
        t.wr_data_in  = monitor.wr_data_in;
        t.ready_out   = monitor.ready_out;
        t.rd_data_out = monitor.rd_data_out;
        t.done_op_id  = monitor.done_op_id;
    endfunction
endinterface : input_interface
class input_item extends uvm_sequence_item;
    `uvm_object_utils(input_item);
    
        rand bit       enable_in;
        rand bit       wr_rd_op;
        rand bit       valid_in;
        rand bit [7:0] addr_in;
        rand bit [7:0] op_id_in;
        rand bit [7:0] wr_data_in;

        bit       ready_out;
        bit [7:0] rd_data_out;
        bit [7:0] done_op_id;
        
    function new(string name = "input_item");
        super.new(name);
    endfunction : new
    
    extern function string convert2string();
endclass : input_item



function string input_item::convert2string();
    return $sformatf("enable_in: 'b%0h  wr_rd_op: 'b%0h  valid_in: 'b%0h  addr_in: 'h%2h  op_id_in: 'h%2h  wr_data_in: 'h%2h  ready_out: 'h%0h  rd_data_out: 'h%2h  done_op_id: 'h%2h", enable_in, wr_rd_op, valid_in, addr_in, op_id_in, wr_data_in, ready_out, rd_data_out, done_op_id);
endfunction : convert2string
class output_item extends uvm_sequence_item;
    `uvm_object_utils(output_item);
    
        rand bit [7:0] rd_data_in;
             bit [4:0] ack_in;

        bit [4:0] sel_en_out;
        bit       wr_rd_s_out;
        bit [7:0] addr_out;
        bit [7:0] wr_data_out;
        
    function new(string name = "output_item");
        super.new(name);
    endfunction : new

    extern function string convert2string();
endclass : output_item



function string output_item::convert2string();
    return $sformatf("rd_data_in: 'h%2h  ack_in: 'd%0d  sel_en_out: 'd%0d  wr_rd_s_out: 'b%0b  addr_out: 'h%2h  wr_data_out: 'h%2h", rd_data_in, ack_in, sel_en_out, wr_rd_s_out, addr_out, wr_data_out);
endfunction : convert2string
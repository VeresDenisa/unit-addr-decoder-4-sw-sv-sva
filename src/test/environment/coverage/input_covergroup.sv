covergroup input_covergroup (ref input_item item);
    wr_rd_op_cvp  : coverpoint item.wr_rd_op { bins value_binary[2] = {0, 1}; }
    valid_in_cvp  : coverpoint item.valid_in { bins value_binary[2] = {0, 1}; }
    enable_in_cvp : coverpoint item.enable_in { bins value_binary[2] = {0, 1}; }
    addr_in_7_5_cvp : coverpoint item.addr_in[7:5] { 
        bins legal_values[5] = {[0:4]}; 
        bins illegal_value = {[5:$]};
    }
    addr_in_4_0_cvp : coverpoint item.addr_in[4:0] { 
        bins legal_values[4] = {[0:3]}; 
        bins illegal_value = {[4:$]};
    }
    wr_data_in_cvp : coverpoint item.wr_data_in { bins value_0_FF[4] = {'h00, 'h55, 'hAA, 'hFF}; }
    op_id_in_cvp   : coverpoint item.op_id_in   { bins value_0_FF[4] = {'h00, 'h55, 'hAA, 'hFF}; }  
    ready_out_cvp : coverpoint item.ready_out { bins value_binary[2] = {0, 1}; }

    data_port_register_cross : cross wr_data_in_cvp, addr_in_7_5_cvp, addr_in_4_0_cvp {}
    wr_rd_data_port_register_cross : cross data_port_register_cross, wr_rd_op_cvp {}
    wr_rd_cases_cross : cross wr_rd_op_cvp, valid_in_cvp, enable_in_cvp {}
endgroup : input_covergroup
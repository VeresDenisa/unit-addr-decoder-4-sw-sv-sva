covergroup output_covergroup (ref output_item item);
    wr_rd_s_out_cvp : coverpoint item.wr_rd_s_out { bins value_binary[2] = {0, 1}; }
    sel_en_out_cvp  : coverpoint item.sel_en_out { 
        bins unique_value[5] = {1, 2, 4, 8}; 
        bins error_value = default;
    }
    addr_out_7_5_cvp : coverpoint item.addr_out[7:5] { 
        bins legal_values[5] = {[0:4]}; 
        bins illegal_value = {[5:$]};
    }
    addr_out_4_0_cvp : coverpoint item.addr_out[4:0] { 
        bins legal_values[4] = {[0:3]}; 
        bins illegal_value = {[4:$]};
    }
    wr_data_out_cvp : coverpoint item.wr_data_out { bins value_0_FF[4] = {'h00, 'h55, 'hAA, 'hFF}; }
    rd_data_in_cvp   : coverpoint item.rd_data_in   { bins value_0_FF[4] = {'h00, 'h55, 'hAA, 'hFF}; }  
    ack_in_cvp : coverpoint item.ack_in { 
        bins unique_value[5] = {1, 2, 4, 8}; 
        bins error_value = default;
    }
    data_port_register_cross : cross wr_data_out_cvp, addr_out_7_5_cvp, addr_out_4_0_cvp {}
    read_data_port_cross : cross rd_data_in_cvp, ack_in_cvp {}
endgroup : output_covergroup
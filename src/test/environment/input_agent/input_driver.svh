class input_driver extends uvm_driver #(input_item);
    `uvm_component_utils(input_driver);

    virtual input_interface input_i;

    input_item item;

    function new (string name = "input_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new 

    extern function void build_phase (uvm_phase phase);
    extern task reset_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass : input_driver



function void input_driver::build_phase (uvm_phase phase);
    super.build_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);

    if(!uvm_config_db#(virtual input_interface)::get(this, "", "input_interface", input_i))
        `uvm_fatal(this.get_name(), "Failed to get reset interface");

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG);
endfunction : build_phase

task input_driver::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> RESET <--"), UVM_DEBUG);
    
    phase.raise_objection(this);

    input_i.enable_in  <= 1'b0;
    input_i.wr_rd_op   <= 1'b0;
    input_i.valid_in   <= 1'b0;
    input_i.addr_in    <= 8'h00;
    input_i.op_id_in   <= 8'h00;
    input_i.wr_data_in <= 8'h00;

    input_i.rst_n <= 1'b1;
    @(input_i.driver);
    input_i.rst_n <= 1'b0;
    @(input_i.driver);
    input_i.rst_n <= 1'b1;

    phase.drop_objection(this);

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> RESET <--"), UVM_DEBUG);
    endtask : reset_phase

task input_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> MAIN <--"), UVM_DEBUG);

    forever begin : send_loop
        seq_item_port.get_next_item(item);
        
        input_i.send(item);
        `uvm_info(get_name(), $sformatf("Drive: %s", item.convert2string), UVM_LOW);
        
        seq_item_port.item_done();
    end : send_loop
    
    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> MAIN <--"), UVM_DEBUG);
endtask : main_phase
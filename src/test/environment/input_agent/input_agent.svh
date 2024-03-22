class input_agent extends uvm_agent;
    `uvm_component_utils(input_agent);
    
    virtual input_interface input_i;

    uvm_sequencer #(input_item) seqr; 
    input_driver  drv;
    input_monitor mon;
    
    input_config input_config_h;
    
    function new (string name = "input_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : input_agent



function void input_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);

    if(!uvm_config_db#(input_config)::get(this, "", "config", input_config_h))
        `uvm_fatal(this.get_name(), "Failed to get config object");
    
    if(!uvm_config_db#(virtual input_interface)::get(this, "", "input_interface", input_i))
        `uvm_fatal(this.get_name(), "Failed to get memory interface");
    
    if(input_config_h.get_is_active() == UVM_ACTIVE) begin
        seqr = uvm_sequencer#(input_item)::type_id::create("input_agent_seqr", this);
        drv  = input_driver::type_id::create("input_agent_driver",  this); 
        uvm_config_db#(virtual input_interface)::set(this, "input_agent_driver*", "input_interface", input_i);
    end
    
    // DEFAULT PASSIVE
    mon = input_monitor::type_id::create("input_agent_monitor",  this);
    uvm_config_db#(virtual input_interface)::set(this, "input_agent_monitor*", "input_interface", input_i);

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG);
endfunction : build_phase

function void input_agent::connect_phase(uvm_phase phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> CONNECT <--"), UVM_DEBUG);

    if(input_config_h.get_is_active() == UVM_ACTIVE) begin
        drv.seq_item_port.connect(seqr.seq_item_export);
    end

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> CONNECT <--"), UVM_DEBUG);
endfunction : connect_phase
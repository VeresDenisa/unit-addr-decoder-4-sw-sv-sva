class input_monitor extends uvm_monitor;
    `uvm_component_utils(input_monitor)
    
    virtual input_interface input_i;
    
    uvm_analysis_port #(input_item) an_port;
    
    input_item item_previous, item_current;
    
    function new (string name = "input_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    
    extern function void build_phase (uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass : input_monitor



function void input_monitor::build_phase (uvm_phase phase);
    super.build_phase(phase);  
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);
    
    item_previous = new();
    item_current = new();
    an_port = new("mon_an_port", this);
    
    if(!uvm_config_db#(virtual input_interface)::get(this, "", "input_interface", input_i))
        `uvm_fatal(this.get_name(), "Failed to get memory interface");  

    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG); 
endfunction : build_phase

task input_monitor::run_phase(uvm_phase phase);
    `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> RUN <--"), UVM_DEBUG);

    forever begin : forever_monitor
        @(input_i.monitor);
        input_i.receive(item_current);
        //if(!item_current.compare(item_previous)) begin
        //`uvm_info(get_name(), $sformatf("Monitored configuration: %s", item_current.convert2string), UVM_MEDIUM);
        //item_previous.copy(item_current);
        an_port.write(item_current);
        //end
    end : forever_monitor
    
    `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> RUN <--"), UVM_DEBUG);
endtask : run_phase

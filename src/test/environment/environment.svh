class environment extends uvm_env;
  `uvm_component_utils(environment);
    
  input_agent input_agent_h;
  
  environment_config env_config_h;
  
  input_config input_config_h;
  
  function new (string name = "environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : environment



function void environment::build_phase(uvm_phase phase);
  super.build_phase(phase);  
  `uvm_info(get_name(), $sformatf("---> ENTER PHASE: --> BUILD <--"), UVM_DEBUG);
  
  if(!uvm_config_db #(environment_config)::get(this, "", "config", env_config_h))
    `uvm_fatal(this.get_name(), "Failed to get environment config");
  
  input_config_h = new(.is_active(UVM_ACTIVE));
      
  uvm_config_db #(input_config)::set(this, "input_agent*", "config", input_config_h);
  
  input_agent_h = input_agent::type_id::create("input_agent", this);
  
  `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> BUILD <--"), UVM_DEBUG);
endfunction : build_phase

function void environment::connect_phase(uvm_phase phase);
endfunction : connect_phase
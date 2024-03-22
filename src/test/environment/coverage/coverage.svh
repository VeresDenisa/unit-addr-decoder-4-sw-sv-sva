`uvm_analysis_imp_decl(_input)
`uvm_analysis_imp_decl(_output)

class coverage extends uvm_component;
  `uvm_component_utils(coverage);
  
  uvm_analysis_imp_input  #(input_item, coverage)  an_port_input;
  uvm_analysis_imp_output #(output_item, coverage) an_port_output;
   
  input_item  input_t;  
  output_item output_t;

  input_covergroup  input_cvg;
  output_covergroup output_cvg;
    
  function new(string name = "coverage", uvm_component parent = null);
    super.new(name, parent);

    an_port_input  = new("an_port_input",  this);
    an_port_output = new("an_port_output", this);
    
    input_t  = new("input_t");
    output_t = new("output_t");

    input_cvg  = new(input_t);
    output_cvg = new(output_t);      
  endfunction : new
  
  extern function void write_input(input_item t);      
  extern function void write_output(output_item t);  
    
  extern function void report_phase(uvm_phase phase);
endclass : coverage

    
    
function void coverage::write_input(input_item t);
  input_t = t;
  input_cvg.sample();
endfunction : write_input
    
function void coverage::write_output(output_item t);
  output_t = t;  
  output_cvg.sample();
endfunction : write_output

function void coverage::report_phase(uvm_phase phase);
  `uvm_info(get_name(), $sformatf("---> EXIT PHASE: --> REPORT <--"), UVM_DEBUG);
  `uvm_info(get_name(), $sformatf("<--- EXIT PHASE: --> REPORT <--"), UVM_DEBUG);
endfunction : report_phase

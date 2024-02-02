class peripheral_uvm_coverage #(type T = peripheral_uvm_transaction) extends uvm_subscriber #(T);
  // Declaration of Local fields
  peripheral_uvm_transaction cov_transaction;

  // Declaration of component utils to register with factory
  `uvm_component_utils(peripheral_uvm_coverage)

  // Functional coverage: covergroup for peripheral_adder
  covergroup peripheral_uvm_cg;
    option.per_instance = 1;
    option.goal = 100;

    peripheral_uvm_rst: coverpoint cov_transaction.rst {
      bins low = {0};
      bins high = {1};
    }

    peripheral_uvm_addr: coverpoint cov_transaction.addr {
      bins addr_values[] = {[0 : $]};
    }

    peripheral_uvm_dout: coverpoint cov_transaction.dout {
      bins dout_values[] = {[0 : $]};
    }

    peripheral_uvm_din: coverpoint cov_transaction.din {
      bins din_values[] = {[0 : $]};
    }

    peripheral_uvm_cen: coverpoint cov_transaction.cen {
      bins low = {0};
      bins high = {1};
    }

    peripheral_uvm_wen: coverpoint cov_transaction.wen {
      bins wen_values[] = {[0 : $]};
    }

    peripheral_uvm_address: coverpoint cov_transaction.address {
      bins address_values[] = {[0 : $]};
    }
  endgroup

  // Constructor
  function new(string name = "peripheral_uvm_reference_model", uvm_component parent);
    super.new(name, parent);
    peripheral_uvm_cg = new();
    cov_transaction   = new();
  endfunction

  // Method name : sample
  // Description : sampling peripheral_adder coverage
  function void write(T t);
    this.cov_transaction = t;
    peripheral_uvm_cg.sample();
  endfunction
endclass

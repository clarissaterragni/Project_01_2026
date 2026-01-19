import vunit.sim_if.ghdl as ghdl
if hasattr(ghdl, "GHDLBackend") and hasattr(ghdl.GHDLBackend, "_backend_mapping"):
    _original_mapping = ghdl.GHDLBackend._backend_mapping.copy()
    ghdl.GHDLBackend._backend_mapping = {
        **_original_mapping,
        r"mcode JIT code generator": "mcode",
    }


from vunit import VUnit

vu = VUnit.from_argv(compile_builtins=False)
vu.add_vhdl_builtins()

lib = vu.add_library("lib")
lib.add_source_files("timer.vhd")
lib.add_source_files("tb_timer.vhd")

tb = lib.test_bench("tb_timer")  # just compile + run testbench

vu.main()

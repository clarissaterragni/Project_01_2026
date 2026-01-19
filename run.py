import vunit.sim_if.ghdl._ghdl as _ghdl

if hasattr(_ghdl, "GHDLBackend") and hasattr(_ghdl.GHDLBackend, "_backend_mapping"):
    _original_mapping = _ghdl.GHDLBackend._backend_mapping.copy()
    _ghdl.GHDLBackend._backend_mapping = {
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

import re
import vunit.sim_if.ghdl as ghdl

_original_mapping = ghdl.GHDLBackend._backend_mapping.copy()

ghdl.GHDLBackend._backend_mapping = {
    **_original_mapping,
    r"mcode JIT code generator": "mcode",
}
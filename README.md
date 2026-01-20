# Parametric Timer


For assumptions made during my reasonings, please refer to assumptions.md file.
Links and notes that were useful during development and I wanted to keep for reference are in sources&useful.md file.
Details regarding the use of AI tools can be found in AI_USAGE.md file.

Local execution was verified on my PC using Python version 3.14.2, GHDL 5.1.1, VUnit HDL 4.7.0.
To run tests locally, make sure they are installed and available in your system path. In the folder of the project, run on the terminal: 
python run.py --verbose 
to launch the VUnit test suite.

To test different combinations of delay and clock frequency, the generic parameters can be modified in the tb_timer testbench. 
For local execution, I used GHDL with the mcode backend, while the CI pipeline uses the LLVM backend. 
The CI pipeline automatically runs the VUnit test suite on every “push” and “pull_request”.

For information on Task 4 (formal verification), please see the last section of AI_USAGE.md file.










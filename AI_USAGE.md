AI tool used: ChatGPT

•	When performing initial debugging in Task 1, I did a testbench on Xilinx ISE, to find and correct first relevant errors. I then used AI to understand the allowed and forbidden operations with “natural” and “time” types, solving the incompatibility issue I initially had run into.

•	Knowing the range (that I stated in assumptions.md) of natural type, I used AI to try in several ways to extend it but couldn’t find a solution due to GHDL's limitations, for example that conversion functions like to\_real are not supported. I tried these solutions and verified them when testbenching.

•	In Task 2 and 3 , I relied heavily on AI through the entire process. After exploiting the User Guide for vunit on Github, AI was very helpful, since I had no prior experience with VUnit, Python or CI pipeline. I faced challenges related to VUnit's setup and its compatibility with GHDL and ended up solving them by directly modifying the ghdl.py file (inside my local Python site-packages installation) to include the “mcode JIT backend” to make everything work properly. Debugging and testing helped me verify the correctness of the codes, using various generic variables values.

•	In Task 3 ChatGPT guided me through the setup of CI pipeline and GitHub Actions. I had to deal with version compatibility issues and, after several attempts, ended up solving them by using the latest Ubuntu version and changing to the llvm backend. I finally ensured that the Vunit tests run automatically and correctly, with different delay-frequency combinations.

* Using AI (because I have no experience regarding Formal Verification), I tried to work on Task 4, creating and adding code to timer.sby and timer\_psl.vhd in the “formal” folder. I downloaded OSS CAD suite with SBY v0.61. However, I was not able to run the tests locally as Yosys did not execute successfully (even though the file exists, the path is set in the system and the Visual redistributables are installed). If the tests locally had produced a positive outcome, I’d have added to the already existing ci.yml file:



name: Install OSS CAD Suite

        uses: YosysHQ/setup-oss-cad-suite@v1

name: Formal verification

        run: |

          cd formal

          sby -f timer.sby


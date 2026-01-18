info on time data type

https://www.vhdl-online.de/courses/system\_design/vhdl\_language\_and\_syntax/data\_types#data\_type\_time



info on vunit and testbench + supported python

https://vunit.github.io/user\_guide.html#user-guide



Steps made:

Install python (https://www.python.org/downloads/)

Check in terminal: python --version



Installed ghdl: https://github.com/ghdl/ghdl/releases

Add C:\\ghdl511\\bin to environment variables



python -m pip install --upgrade pip

python -m pip install vunit\_hdl

had to change in ghdl.py to add r"mcode JIT code generator": "mcode", otherwise wouldn’t work



Running run.py:

python run.py in folder

python run.py --verbose to see the printed logs

see printed messages in output.txt in vunit\_out/test\_output


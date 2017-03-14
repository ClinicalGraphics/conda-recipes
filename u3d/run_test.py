"""
Test that the exit code generated is ok
Runs the IDTFConverter -input test.idtf -output test.u3d and checks the exit code
"""
import os
import subprocess
import sys

# Generate a idtf file
subprocess.run(['IDTFGen'])

# Convert to u3d file.
p = subprocess.run(['IDTFConverter', '-input', 'test.idtf', '-output', 'test.u3d'], shell=False, check=True,
                   stdout=subprocess.PIPE)

exit = p.stdout.decode(sys.stdout.encoding)
code_index = exit.index("Exit code = ")
exit_code = exit[code_index + len("Exit code = "): len(exit)]
exit_code = exit_code.replace("\n", "")

# Check that the file exists
cwd = os.getcwd()
file_path = os.path.join(cwd, 'test.u3d')

if exit_code != '0' or not os.path.isfile(file_path):
    raise ValueError("U3d build failed - Failed to generate U3d file. "
                     "Exit code = " + exit_code +
                     "File path = " + file_path)

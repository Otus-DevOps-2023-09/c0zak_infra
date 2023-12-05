import subprocess
import os

def run_tflint():
   os.chdir("terraform/stage")
   cmd = ["tflint"]
   return subprocess.run(cmd, capture_output=True, text=True)

result = run_tflint()

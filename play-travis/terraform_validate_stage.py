import subprocess
import os

def run_terraform_validate():
   os.chdir("terraform/stage")
   cmd = ["terraform", "validate"]
   return subprocess.run(cmd, capture_output=True, text=True)

result = run_terraform_validate()

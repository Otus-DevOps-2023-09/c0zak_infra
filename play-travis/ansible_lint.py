import subprocess
import os

def run_ansible_lint():
   os.chdir("ansible")
   cmd = ["ansible-lint", "playbooks/site.yml"]
   return subprocess.run(cmd, capture_output=True, text=True)

result = run_ansible_lint()

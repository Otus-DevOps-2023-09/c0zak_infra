#!/usr/bin/python

import os
import json
import subprocess
import sys

def main():
   if len(sys.argv) > 1 and sys.argv[1] == "--list":
       data = {
           "_meta": {
               "hostvars": {}
           },
           "all": {
               "children": ["app", "db"]
           },
           "app": {
               "hosts": []
           },
           "db": {
               "hosts": []
           }
       }

       os.chdir("../terraform/stage")
       output = subprocess.check_output(["terraform", "output", "-json"]).decode()
       output_dict = json.loads(output)

       data["app"]["hosts"].append(output_dict["external_ip_address_app"]["value"])
       data["db"]["hosts"].append(output_dict["external_ip_address_db"]["value"])

       print(json.dumps(data, indent=4))

if __name__ == "__main__":
   main()

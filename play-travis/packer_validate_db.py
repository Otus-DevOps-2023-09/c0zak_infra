from packerpy import PackerExecutable

p = PackerExecutable("/usr/bin/packer")
template = 'packer/db.json'
p.validate(template, var_file="packer/variables.json")

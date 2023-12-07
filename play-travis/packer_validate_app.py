from packerpy import PackerExecutable

p = PackerExecutable("/usr/bin/packer")
template = 'packer/app.json'
p.validate(template, var_file="packer/variables.json")

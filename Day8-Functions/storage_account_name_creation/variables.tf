variable "project_name" {
  type = string
  description = "name of the project"
  default = "PROJECT TEST NIKE"
}

variable "Dev_tags" {
  type = map(string)
  default = {
    "Company" = "IBM"
     "Owner" = "Machan"
  }
}

variable "Testing-Tags" {
  type = map(string)
  default = {
    "env" = "Zoho"
    "cost" = "My"
  }
}


variable "storage_accountname" {
  type = string
  default = "Learingfunstions VVVVVVSSSSGGGRRWGGGDDD with tech &^^^ bjkkjadskhgadsihgadsihajsjafsgjfjfsdjfsihfgjbagdyuaftydadgfskjbshfgadfhjhjdfuhfhdsvyu"
  
}
state_s3_bucket = "casebook-tfstate"
app_name= "seleniumgrid"
env="dev"
vpc_id = "vpc-08ce07a1854be2fb3"
subnet_ids_nodes = ["subnet-0b967069a049bcf41", "subnet-0e87e0d51c25ca0d4", "subnet-0257e44269939b59d"]
subnet_ids_hub = ["subnet-0b967069a049bcf41", "subnet-0e87e0d51c25ca0d4", "subnet-0257e44269939b59d"]
subnet_ids_elb = ["subnet-01db5721deb8de1cc", "subnet-0d3aebcc8da169289", "subnet-044c91019a4c01cfa"]

hub_cpu = 1024
hub_mem = 2048
chrome_cpu = 2048
chrome_mem = 4096
firefox_cpu = 2048
firefox_mem = 4096
edge_cpu = 2048
edge_mem = 4096

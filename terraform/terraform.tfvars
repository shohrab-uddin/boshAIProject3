# Azure subscription vars
subscription_id = "09e822a9-d2e3-40f8-885b-ae82ab7bffdd"
client_id = "21db35cb-acfd-4463-aa74-7210b5596ac9"
client_secret = "ICE8Q~IChZkUhj5R6JXFqBNAlbL8SQ-5f0E1Gc_6"
tenant_id = "f958e84a-92b8-439f-a62d-4f45996b6d07"


# SSH public key that is located in azure portal in ~/.ssh/id_rsa.pub
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/t0NS7I7VVL9c98FHHGKgoppCi806hRsor4YKI2fznIpEpYVoDMfMshhJTYoTUA56QNQg0Trt730CaXC3D9dq3Lrae3B/xC4CP1FEz7uAOd4T+zeM4M6+853mUBQjI8lXW13iJ8ZUzmVBCbfI4Zu5WJxlJGu+/W7tIvY7C36ln02X/JkCCtzCHzXQhFhVWujZqfcjWSaYUmvH+dKCtgTgv14uE4T+ezbrfr4uvq0nxuXN9d4UClNYP1ttDc9hZ1LwyNp0fOIg6TZzo/GoiW1XaDI09MO9eKv1xOWpYO5nz3mGUkg8GOUsyazWa8Lag5jZYCXN0nBSmfkS4fZdjjvV9nbbFZ3+yxQcZb7UwJT0Y6dZgpmV6GB2L+jrfPx2jtTS6l2s0w3Obb1Ass2CHwEqx+ohHPNjdbg3dV+j736K17NZFp4liybGnSdXqucaiXIg7ZVyPkBJBQ/8af/sAsGBZGjSz2RTEOeXeS2XH+7UYIyi8wxEMymEwEuoUIq4F0M= shohrab@cc-8e6dc24c-7d65c56f6b-b6hdl"

# Resource Group/Location
location = "East US"
resource_group = "p3rg2"
application_type = "p3application" # This name has to be globally unique.

# Network
virtual_network_name = "p3vm"
address_space = ["10.5.0.0/16"]
address_prefix_test = "10.5.1.0/24"

# Tags
demo = "project3demo"

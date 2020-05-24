# digi
terraform demo for digitalents azure course

## initialize and smoke test:
0. az login (if using local az cli)
1. edit terraform.tfvars
2. cp add/main.tf .
3. terraform init
4. terraform plan -out plan
5. terraform apply plan

## add network items
6. cat add/networks.tf >> main.tf
7. terraform plan -out plan
8. terraform apply plan

## create ssh keys if they do not exist, accept default values
9. [ -n ~/.ssh/id_rsa.pub ] && ssh-keygen && chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_rsa.pub

## add vm with ephemeral disk and ssh key
10. cat add/vm.tf >> main.tf
11. terraform plan -out plan
12. terraform apply plan

## test ssh and deploy demo app
13. ip=$(terraform output ip1)
14. ssh azureuser@$ip
15. exit
16. scp -r Books/ azureuser@$ip:./

## run demo app
17. ssh azureuser@$ip
18. cd Books
19. npm install
20. npm install mongoose@5.9.15
21. sudo node server.js

## navigate browser to ip address and insert demo books.

## test some changes to app. redeploy app.

## clean up.
22. terraform destroy


test: init validate fmt lint

init:
	terraform init

validate: init
	terraform validate

fmt:
	terraform fmt -recursive

lint:
	tflint --init
	tflint

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve
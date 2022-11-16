test: init validate fmt lint
	cd test && go test -v || cd ..

init:
	terraform init

validate: init
	terraform validate

fmt:
	terraform fmt -recursive

lint:
	tflint || tflint --init && tflint

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve
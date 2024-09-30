.PHONY: deploy destroy

deploy: deploy-lambdas
	cd terraform && terraform apply --auto-approve

destroy:
	cd terraform && terraform init && terraform destroy --auto-approve

deploy-lambdas:
	./scripts/deploy-login.sh
	./scripts/deploy-pre-signup.sh
	./scripts/deploy-signup.sh
	./scripts/deploy-email.sh
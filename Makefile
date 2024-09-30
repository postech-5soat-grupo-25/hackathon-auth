.PHONY: deploy destroy

deploy: deploy-lambdas
	cd terraform && terraform init && terraform apply --auto-approve

destroy:
	cd terraform && terraform init && terraform destroy --auto-approve

deploy-lambdas:
	./deploy-login.sh
	./deploy-pre-signup.sh
	./deploy-signup.sh
	./deploy-email.sh
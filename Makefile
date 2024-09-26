.PHONY: deploy destroy

deploy:
	cd source/lambda/auth && zip -r ../auth.zip .
	cd source/lambda/email && zip -r ../email.zip .
	cd terraform && terraform init && terraform apply --auto-approve

destroy:
	cd terraform && terraform init && terraform destroy --auto-approve
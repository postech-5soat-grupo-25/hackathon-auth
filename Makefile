.PHONY: deploy destroy

deploy:
	cd source/lambda && zip -r ../lambda.zip .
	cd terraform && terraform init && terraform apply --auto-approve

destroy:
	cd terraform && terraform init && terraform destroy --auto-approve
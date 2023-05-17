DEPLOYMENT_BUCKET ?= sharpsell-ffmpeg-lambda-layer
STACK_NAME ?= sharpsell-ffmpeg-lambda-layer
PROFILE ?= sharpsell-ffmpeg-lambda-deploy-role

clean: 
	rm -rf build

build/layer/bin/ffmpeg: 
	mkdir -p build/layer/bin
	rm -rf build/ffmpeg*
	cd build && curl https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz | tar x
	mv build/ffmpeg*/ffmpeg build/ffmpeg*/ffprobe build/layer/bin

build/output.yaml: template.yaml build/layer/bin/ffmpeg
	aws s3api head-bucket --bucket $(DEPLOYMENT_BUCKET) --profile $(PROFILE) &>/dev/null || aws s3 mb s3://$(DEPLOYMENT_BUCKET) --profile $(PROFILE)
	aws cloudformation package --template $< --s3-bucket $(DEPLOYMENT_BUCKET) --output-template-file $@ --profile $(PROFILE)

deploy: build/output.yaml
	aws cloudformation deploy --template $< --stack-name $(STACK_NAME) --profile $(PROFILE)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs --output table --profile $(PROFILE)

# FFmpeg/FFprobe for AWS Lambda

A Lambda layer containing a static version of FFmpeg/FFprobe utilities from the [`FFmpeg`](https://www.ffmpeg.org/) Linux package, compatible with Amazon Linux 2.x and Amazon Linux 1.x instances (including the `nodejs16.x` runtime, and the updated 2018.03 Amazon Linux 1 runtimes).

## Deploying the lambda layer

### Prerequisites

- Unix Make environment
- AWS command line utilities (just for deployment)

### Deploying to AWS as a layer

This package includes FFmpeg 4.1.3, packaged by John Van Sickle. Please consider supporting him for maintaining statically built FFmpeg packages. For more information, check out <https://johnvansickle.com/ffmpeg/>

The output will be in the `result` dir.

Run the following command to deploy the compiled result as a layer in your AWS account.

```bash
make deploy DEPLOYMENT_BUCKET=<YOUR BUCKET NAME> STACK_NAME=<YOUR STACK NAME> PROFILE=<YOUR AWS PROFILE>
```

> **Warning**
> Make sure that the value passed to `DEPLOYMENT_BUCKET` is unique across all AWS accounts. Defaults to `sharpsell-ffmpeg-lambda-layer`.

- The value passed to `STACK_NAME` is used to name the CloudFormation stack that will be created. Defaults to `sharpsell-ffmpeg-lambda-layer`.
- The value passed to `PROFILE` is used to specify the AWS profile to use for deployment. This user must have permissions to create CloudFormation stacks and S3 buckets. Defaults to `sharpsell-ffmpeg-lambda-deploy-role`. Contact the maintainer for more information

## Author

Gojko Adzic <https://gojko.net>

## License

- These scripts: [MIT](https://opensource.org/licenses/MIT)
- FFmpeg: GPLv2.1 <http://ffmpeg.org/legal.html>, John Van Sickle's static build GPL v3 <https://johnvansickle.com/ffmpeg/>

## LGPL version

- [Giuseppe Battista](http://github.com/giusedroid) created a build that contains only LGPL components, for organisations that are concerned about GPL licensing. See it at <https://github.com/giusedroid/ffmpeg-aws-lambda-layer/tree/license/lgpl>

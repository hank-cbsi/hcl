import * as s3 from '@aws-cdk/aws-s3';
import * as cdk from '@aws-cdk/core';

export class BucketStack extends cdk.Stack {
    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
      super(scope, id, props);
    
    const myBucket = new s3.Bucket(this, 'MyTestBucket', {bucketName: 'i-aws-sports-sharedservices-dev-cdk-test-bucket'});
    
}
}
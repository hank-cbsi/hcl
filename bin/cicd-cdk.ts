#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { CicdCdkStack } from '../lib/cicd-cdk-stack';
import { BucketStack } from '../lib/test-cdk-stack';
import { LambdaStack } from '../lib/resources/test-lambda-stack';

const myCdkStakProps = {
    env: {
        account: '337089113773',
        region: 'us-east-1'
    }
}
const app = new cdk.App();
const lambdaStack = new LambdaStack(app, 'LambdaStack')
const testStack = new BucketStack(app, 'BucketStack');
new CicdCdkStack(app, 'CicdCdkStack', myCdkStakProps);

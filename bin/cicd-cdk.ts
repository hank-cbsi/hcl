#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { CicdCdkStack } from '../lib/cicd-cdk-stack';

const myCdkStakProps = {
  env: {
  account: '337089113773',
  region: 'us-east-1'
}
}
const app = new cdk.App();
new CicdCdkStack(app, 'CicdCdkStack', myCdkStakProps);

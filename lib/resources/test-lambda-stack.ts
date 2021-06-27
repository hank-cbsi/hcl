import * as lambda from '@aws-cdk/aws-lambda';
import * as cdk from '@aws-cdk/core';
import * as iam from '@aws-cdk/aws-iam';

export class LambdaStack extends cdk.Stack {

    public readonly nebulaSecretsOtpLambda: lambda.Function;

    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        //  Define some variables 
        const lambdaSource = "lib/resources/lambda";
        const project = "nebulaSecretsOtp";
        const lambdaFunctionHandler = "index";

        // Define the lambda role properties
        const nebulaSecretsOtpLambdaRoleProps = {
            assumedBy: new iam.ServicePrincipal('lambda.amazonaws.com').grantPrincipal,
            description: 'The IAM role supporting the ' + project + ' Lambda function',
            RoleName: project + '-Lambda-Role'
        };

        // Define my lambda role
        const nebulaSecretsOtpLambdaRole = new iam.Role(this, project + '-Lambda-Role', nebulaSecretsOtpLambdaRoleProps);
        const myIRole = iam.Role.fromRoleArn(this, project + '-Lambda-IRole', nebulaSecretsOtpLambdaRole.roleArn)

        //  I need to figure out how to make this work
        const functionTimeout = cdk.Duration.seconds(30);

        var nebulaSecretsOtpLambdaProps = {
            functionName: project,
            description: 'Lambda function supporting the ' + project + ' project',
            runtime: lambda.Runtime.NODEJS_14_X,
            handler: lambdaFunctionHandler + '.handler',
            code: lambda.Code.fromAsset(lambdaSource),
            role: myIRole,
            //    I need to figure out how this works
            //   timeout: functionTimeout
        }

        const nebulaSecretsOtpLambda = new lambda.Function(this, project + '-lambda', nebulaSecretsOtpLambdaProps);

        // Start Create Statements
        const Statement1 = new iam.PolicyStatement({
            effect: iam.Effect.ALLOW,
            actions: ['secretsmanager:GetSecretValue', 'secretsmanager:ListSecretVersionIds', 'secretsmanager:ListSecrets'],
            sid: 'allowSecretManagerRead',
            resources: ['*']
        });

        const Statement2 = new iam.PolicyStatement({
            effect: iam.Effect.ALLOW,
            actions: ['Logs:*'],
            sid: 'AllowCloudwatchReadWrite',
            resources: ['*']
        });
        // End Create Statements

        // Create a policy
        const myLambdaRolePolicyProps = {
            policyName: project + '-Lambda-Role-Policy',
            statements: [Statement1, Statement2]
        }

        const myLambdaRolePolicy = new iam.Policy(this, project + '-Lambda-Role-Policy', myLambdaRolePolicyProps);
        myLambdaRolePolicy.attachToRole(myIRole);

    }
    
}
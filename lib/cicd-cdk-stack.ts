import * as cdk from '@aws-cdk/core';
import * as codepipeline_actions from '@aws-cdk/aws-codepipeline-actions';
import { Pipeline, Artifact} from '@aws-cdk/aws-codepipeline';
import { ServicePrincipal, Role, ManagedPolicy } from '@aws-cdk/aws-iam';
import { BuildSpec, PipelineProject } from '@aws-cdk/aws-codebuild';
import { LambdaApplication, LambdaDeploymentGroup } from '@aws-cdk/aws-codedeploy';

export class CicdCdkStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    //  Define some generic variables.
    const name: string = 'NebulaPipeline'
    const description: string = 'resource for the Nebula CI/CD service.'

    // define my source action variables
    const sourceActionName: string = 'GetNebulaSourceFromGithub';
    const sourceActionConnectionArn: string = 'arn:aws:codestar-connections:us-east-1:337089113773:connection/d03539f9-0da4-439d-94c4-07c3c4f2e67a';
    const sourceOutputArtifactName: string = 'sourceOutput';
    const repoOwner: string = 'cbs-sports';
    const repoName: string = 'ops-nebula';
    const sourceOutputArtifact = new Artifact(sourceOutputArtifactName);

    // define build related variables 
    const buildspecFileName = 'lib/resources/buildspec.yml'

    //  define a role props and a role
    const pipelineRoleProps = {
      roleName: name + '-build1',
      assumedBy: new ServicePrincipal('codepipeline.amazonaws.com'),
      description: 'Role ' + description,
      managedPolicies: [ManagedPolicy.fromAwsManagedPolicyName('AdministratorAccess')],
    };
    const pipelineRole = new Role(this, 'NebulePipelineRole', pipelineRoleProps)

    // define a source action propertie and source action objects
    const mySourceActionProps = {
      actionName: sourceActionName,
      connectionArn: sourceActionConnectionArn,
      output: sourceOutputArtifact,
      owner: repoOwner,
      repo: repoName,
      runOrder: 1
    }
    const mySourceAction = new codepipeline_actions.CodeStarConnectionsSourceAction(mySourceActionProps);

    // defina a build project properties and the build project for the codepipeline pipeline
    const myPipelineBuildProjectProps = {
      projectName: name,
      desctiption: 'Build project for ' + description,
      buildSpec: BuildSpec.fromSourceFilename(buildspecFileName),

    };
    const myPipelineBuildProject = new PipelineProject(this, 'NebulaCodebuildProject', myPipelineBuildProjectProps);
    const lambdaBuildOutput = new Artifact('LambdaBuildOutput');
    // defind my build action properties and build action
    const myBuildActionProps = {
      actionName: 'Build',
      input: sourceOutputArtifact,
      project: myPipelineBuildProject,
      role: pipelineRole,
      outputs: [lambdaBuildOutput]
    }
    const myBuildAction = new codepipeline_actions.CodeBuildAction(myBuildActionProps);
 // ###############################################
    const myDeployActionProps = {
      actionName: 'DeployLambda',
      adminPermissions: true,
      stackName: 'LambdaStack',
      templatePath: lambdaBuildOutput.atPath('BucketStack.template.json')
    };
    const myDeployAction = new codepipeline_actions.CloudFormationCreateUpdateStackAction(myDeployActionProps)
 
 // ###############################################
    const nebulaPipelineProps = {
      pipelineName: name,
      role: pipelineRole,
      stages: [
        {
          stageName: 'Source',
          actions: [mySourceAction]
        },
        {
          stageName: 'Build',
          actions: [myBuildAction]
        },
        {
          stageName: 'Deploy',
        actions: [myDeployAction]}
      ]
    }
    const nebulaPipeline = new Pipeline(this, 'nebulaPipeline', nebulaPipelineProps)
  }
}
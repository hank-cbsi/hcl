import * as cdk from '@aws-cdk/core';
import * as codepipeline_actions from '@aws-cdk/aws-codepipeline-actions';
import { Pipeline } from '@aws-cdk/aws-codepipeline';
import { Artifact } from '@aws-cdk/aws-codepipeline';
import { ServicePrincipal, Role, ManagedPolicy } from '@aws-cdk/aws-iam';
import { BuildSpec, PipelineProject } from '@aws-cdk/aws-codebuild';

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

    //  define a role props and a role
    const pipelineRoleProps = {
      roleName: name + '-build',
      assumedBy: new ServicePrincipal('codepipeline.amazonaws.com'),
      description: 'Role ' + description,
      managedPolicies: [ManagedPolicy.fromAwsManagedPolicyName('AdministratorAccess')],
    };
    const pipelineRole = new Role(this, 'PipelineRole', pipelineRoleProps)

    const mySourceActionProps = {
      actionName: sourceActionName,
      connectionArn: sourceActionConnectionArn,
      output: sourceOutputArtifact,
      owner: repoOwner,
      repo: repoName,
      runOrder: 1
    }
    const mySourceAction = new codepipeline_actions.CodeStarConnectionsSourceAction(mySourceActionProps);

    const buildspecFileName = 'lib/resources/buildspec.yml'

    const myPipelineBuildProjectProps = {
      projectName: name,
      desctiption: 'Build project for ' + description,
      buildSpec: BuildSpec.fromSourceFilename(buildspecFileName),

    };
    const myPipelineBuildProject = new PipelineProject(this, 'NebulaCodebuildProject', myPipelineBuildProjectProps);

    // defind my build action properties and build action
    const myBuildActionProps = {
      actionName: 'Build',
      input: sourceOutputArtifact,
      project: myPipelineBuildProject,
      role: pipelineRole
    }
    const myBuildAction = new codepipeline_actions.CodeBuildAction(myBuildActionProps);

    //  Define codepipeline props and codepipeline pipeline
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
        }
      ]
    }
    const nebulaPipeline = new Pipeline(this, 'nebulaPipeline', nebulaPipelineProps)
  }
}

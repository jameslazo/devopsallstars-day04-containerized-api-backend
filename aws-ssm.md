# Using AWS Session Manager

## [Session Manager prerequisites](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-prerequisites.html)

**Supported operating systems**
- All AWS Linux & MacOS versions supported by AWS SSM
- Windows Server 2012 through Windows Server 2022

**SSM Agent**
- AWS SSM Agent > 2.3.68.0
- for AWS KMS keys > 2.3.539.0
- With shell: > 3.0.222.0
- With stream data (logs) > 3.0.284.0
- User: ssm-user

**Connectivity to endpoints**

The managed nodes you connect to must also allow HTTPS (port 443) outbound traffic to the following endpoints:
- ec2messages.`region`.amazonaws.com
- ssm.`region`.amazonaws.com
- ssmmessages.`region`.amazonaws.com

**AWS CLI**
- AWS CLI > 1.16.12

## [Verify or add instance permissions for Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-instance-profile.html)
Set up [instance profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-usingrole-instanceprofile.html) 
OR [`AmazonSSMManagedEC2InstanceDefaultPolicy`](https://docs.aws.amazon.com/systems-manager/latest/userguide/fleet-manager-default-host-management-configuration.html)

## [Add Session Manager permissions to an existing IAM role](https://docs.aws.amazon.com/systems-manager/latest/userguide/getting-started-add-permissions-to-existing-profile.html)
By adding permissions to an existing role, you can enhance the security of your computing environment without having to use the 
AWS `AmazonSSMManagedInstanceCore` policy for instance permissions.

**Create inline policy**
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetEncryptionConfiguration"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": "<key-name>"
        }
    ]
}
```
*Remove last permission if not using AWS KMS encryption for session data*

# AWS API Gateway and DynamoDB

# High level architect diagram

![GitHub Logo](/images/RESTapi_HighOverview.png)

## How to use this repo

### Steps 1 : Clone repository using below git command:

```
git clone https://github.com/yogmangela/RESTapi.git
```

and go to main.tf

### Step 2 : Add your secrete_key, Access_key and aws_region

#### note: this is not best practice to use secrete_key & Access_key  this is just for a demo purpose.

#### Below are some best practice of Terraform secretes

#### Set secrets via environment variables,Use HashiCorp Vault, AWS Secretes manager, AWS System service

#### It is best practice to store / manage terraform statefile on s3 bucket using DynamoDB.

### Step 3 : Provisioning AWS services API Gateway and DynamoDB. run below command

```
terraform init

terraform validate 

terraform plan

terraform apply  - yes
```

### Step 4 : You will have API and DynamoDB service up

- - copy ROLE ARN: arn:aws:iam::xxxxxxxx:role/test-role

Check for policies:

add policy: 
```
AmazonAPIGatewayPushToCloudWatchLogs
AmazonAPIGatewayAdministrator 
AmazonDynamoDBFullAccess

```

### make sure IAM Role has following policy attached:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "*"
        }
    ]
}
```

###  Step 5: create new "resource" with Resource Path* ```{noteId}```

create >> POST method under {noteId} resource just created and edit configuration as below.


Go to AWS API Gateway service >> Click "mydemoresource" >> Click Action "Create Method" >> select "POST" then save. 

- fill in as shown in below image and click save.
Integrationtype: AWS Service
AWS Region: Select your region
AWS Service: DynamoDB
HTTP Method: POST
Action: PutItem
Execution Role: add your Role created step 4.

![GitHub Logo](/images/AWS_APIGateway.png)


### Step 6 : Add mapping fields:

 Click "Integration Request"  >> expand "apping Templates" >> click on "Add mapping template" type ```application/json``` in the text field and save and "Yes, secure this integration" 

Add below:

```

{ 
    "TableName": "notesireland",
    "Item": {
    "DateTime": {
            "S": "$context.requestTime"
            },
        "noteId": {
            "S": "$input.path('$.noteId')"
            },
        "notes": {
            "S": "$input.path('$.notes')"
        },
        "myDate":{
            "S":"$input.path('$.myDate')"
        }
    }
}

```

Go back to Method-execution click>> TEST

add below sample record.
```
{
    "noteId":"31",
    "notes":"hello 31",
    "myDate":"31-07-2020"
}
```

### Step 7 : TO Deploy API >> Click Action and "Deploy API"

![GitHub Logo](/images/Deploy_API.PNG)

copy  END point: 

Invoke URL: https://asdakhfsdsdohhfadf-api.eu-west-2.amazonaws.com/Production/mydemoresource/{noteId}

### Step 8 : Install [Postman](https://www.postman.com/)

Use Postman to test your POST API:

Add URI to POST:

add Authorization: add your credentials.

under body : add below json record to test

```
{
	"noteId":"02",
	"myDate":"24/07/2020",
	"notes":"MY test 24"
}
```

Click SEND to see record in DynamoDB:

![GitHub Logo](/images/DynamoRecords.PNG)


Attaching AWS Cognito to CURL POST request direct from commandline. Create user pool/ token.

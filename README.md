# genai-sample-app

Generative AI Sample application

For this application, we use AWS ECS Fargate for running the application front-end. The application is exposed to internet through an AWS Application Load Balancer. I referenced this blog for a quick start.

**Frontend:** I came to know about Streamlit.io recently from Sreekrishnan Venkateswaran. A super easy way to create frontend application in no time! So I though of using Streamlit. Though Streamlit provides a hosting environment, I wanted to run my application in AWS environment.

**Application Language:** I used Python as the language for coding the application. I found it easy because all what I needed to run this application is available natively as modules in Python ( Streamlit, LLM, Bedrock…etc)

**Backend:** I used AWS newly released Amazon Bedrock as the backend. Amazon Bedrock is a fully managed Generative AI service on AWS. When Compared to Amazon Sagemaker, using Bedrock is super easy and cost effective for starters. The billing mechanism for Bedrock is by the number of token consumed in each query. You may also get a playground to play around with different GenAI models provided by Bedrock.

I used the Amazon Titan Text Generation 1 (G1) - Express, a base model natively available in AWS for the text processing. I used Langchain Bedrock LLM for processing the input text file and pass it on to AWS Bedrock for providing the output.

**Deployment automation:** Since I was familiar with Terraform, I thought of using Terraform for deploying the whole application components to AWS. You can find the whole code link at the bottom of this page. (Though, I am not covering the ALB deployment in this demo/code).

## Pre-requisites

You need to have the following to get started,

1. An AWS Account with sufficient AWS Credits to deploy a VPC, ECS Cluster, ECR and Amazon Bedrock enabled.
2. A Workstation/Laptop where you have Docker Engine running.
3. Terraform CLI installed on your workstation
4. Patience :-)

## How to use

1. Clone this repo
2. Configure your AWS Access Credentials.
3. Edit the variables in [variables.tf](./variables.tf) according to your environment
4. Initialize Terraform by running `terraform init`
5. Perform a Terraform plan by running `terraform plan`
6. If everything looks good, deploy by running `terraform apply -auto-approve`
7. Watch the demo to see how to use the application.

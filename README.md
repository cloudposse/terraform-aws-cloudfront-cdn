# tf_cdn

Terraform Module that implements a CloudFront Distribution (CDN) for a custom origin (e.g. website) and [ships logs to a bucket](https://github.com/cloudposse/tf_log_storage). 

If you need to accelerate an S3 bucket, we suggest using [`tf_cdn_s3`](https://github.com/cloudposse/tf_cdn_s3) instead.

## Usage

### Generating ACM Certificate

Use the AWS cli to [request new ACM certifiates](http://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request.html) (requires email validation)
```
aws acm request-certificate --domain-name example.com --subject-alternative-names a.example.com b.example.com *.c.example.com
```


## Variables

|  Name                        |  Default       |  Description                                            | Required |
|:-----------------------------|:--------------:|:--------------------------------------------------------|:--------:|
| namespace                    | ``             | Namespace (e.g. `cp` or `cloudposse`)                   | Yes      |
| stage                        | ``             | Stage (e.g. `prod`, `dev`, `staging`)                   | Yes      |
| name                         | ``             | Name  (e.g. `bastion` or `db`)                          | Yes      | 
| attributes                   | []             | Additional attributes (e.g. `policy` or `role`)         | No       | 
| tags                         | {}             | Additional tags  (e.g. `map("BusinessUnit","XYZ")`      | No       |

## Outputs

| Name              | Decription            |
|:------------------|:----------------------|
| id                | Disambiguated ID      |


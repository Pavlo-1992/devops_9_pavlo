import boto3

region = 'eu-west-2'
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    # Шукаємо лише інстанси зі станом "running" і тегом Name=savanchuk
    response = ec2.describe_instances(
        Filters=[
            {"Name": "instance-state-name", "Values": ["running"]},
            {"Name": "tag:Name", "Values": ["savanchuk"]}
        ]
    )
    
    # Збираємо всі IDs
    instance_ids = [
        instance["InstanceId"]
        for reservation in response.get("Reservations", [])
        for instance in reservation.get("Instances", [])
    ]
    
    if instance_ids:
        try:
            print(f"Stopping instances: {instance_ids}")
            ec2.stop_instances(InstanceIds=instance_ids)
            print(f"Successfully stopped: {instance_ids}")
        except Exception as e:
            print(f"Error while stopping instances: {e}")
    else:
        print("No running instances found with tag Name=savanchuk")

    return {"statusCode": 200}


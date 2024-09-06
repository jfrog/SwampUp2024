import yaml
import uuid

with open('example.yaml') as f:
    random = uuid.uuid4()
    print(random)
    data = yaml.full_load(f)
    print(data)

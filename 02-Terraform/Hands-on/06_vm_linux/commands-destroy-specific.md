# Destroy Specific Resources
- Terraform destroy is a command that allows you to destroy either a full stack (based on your TF files), or single resources, using the -target option. You can even do:

```
terraform state list
```

```
terraform destroy -target RESOURCE_TYPE.NAME -target RESOURCE_TYPE2.NAME
```

```
terraform state list
```

### How to remove single resource from the Terraform state?
- Remove a Resource
```
terraform state rm module.foo.packet_device.worker[0]
```

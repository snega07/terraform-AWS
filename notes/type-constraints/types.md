## Primitive Type
**String**

String literal used to pass dymanic values to the resources configuration.

**Number**

Data type used specify numeric values. Such as count and other.

**Bool**

True or False :Used in flags such as associate publicIP, monitoring and other which supports true or false.

## Complex

**List**
- Ordered collection.
- Elements are accessed using an index.
- Supports a single data type.
- Allows duplicate values.
- can't be inerated using for each

``` hcl
variable "instance_type"{
    type = list(string)
    default ["t2.micro", "t3.micro"]
}
```

**Tuple**

- Ordered collection.
- Elements are accessed using an index.
- Supports different data types.
- Allows duplicate values.
- can't be inetrated using for each.

``` hcl
variable "instance_meta"{
    type = tuple([string, number, bool])
    default = ["dev", 1, true]
}
```

**Set**
- Unordered collection.
- Cannot be accessed using an index.
- Supports a single data type.
- Duplicate values are automatically removed.

``` hcl
toset(["dev", "test", "dev"])

Result:
["dev", "test"]
```

**Map**

- Collection of key-value pairs.
- Keys are always strings.
- All values must be the same data type.
- Access values using the key, not an index.

``` hcl
{
  dev  = "10.0.1.0/24"
  test = "10.0.2.0/24"
}

Access:

local.subnets["dev"]
# or
local.subnets.dev

```

**Object**

- Collection of key-value pairs.
- Keys are always strings.
- Values can have different data types.
- Access values using the attribute name (key).
- Can also be iterated using for_each or for expressions.

``` hcl
{
  name    = "web"
  cpu     = 2
  enabled = true
}

Access:

local.server.name
local.server.cpu
```

**Any**
Auto detect the datatypes based on the value. Accepts any Terraform data type.
Terraform automatically infers the actual type from the value provided.

Example:

variable "data" {
  type = any
}

✅ If you explicitly write type = any, the variable's type is any.
✅ If you don't specify a type, Terraform does not automatically make it any. Instead, it infers the type from the default value (if there is one).
✅ If you don't specify the data type etrraform will accept the given input from tfvars file and treat the variable of that type. Its always best practice to specify the datatype.

**Type Inference**

When Terraform infers the type automatically:

All elements are the same type → Terraform infers a list.
Elements are different types → Terraform infers a tuple.

Similarly:

All map values are the same type → Terraform infers a map.
Map values are different types → Terraform infers an object.

**null**

null is a special value in Terraform that represents the absence of a value. It is not a data type. When an argument is set to null, Terraform generally treats it as if the argument was omitted, allowing defaults or provider behavior to take effect. This is especially useful in reusable modules where some inputs are optional.

variable "instance_type" {
  type    = string
  default = null
}

Here:

The variable type is string. The default value is null. If the user doesn't provide a value:

var.instance_type is: null
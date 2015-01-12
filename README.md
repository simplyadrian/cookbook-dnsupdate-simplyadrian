dnsupdate-nativex Cookbook
==========================
This cookbook creates a DNS entry in amazons Route53 services on the first chef run and then updates the created record with the private IP if changed on each subsequent run.

Requirements
------------

#### packages
- `nokogiri` - dnsupdate-nativex needs nokogiri to run on debian systems.
- `aws-sdk` - dnsupdate-nativex utilizes the aws-sdk to perform it's tasks.
- `rubygem` - dnsupdate-nativex utilizes the rubygem package.

Attributes
----------
#### dnsupdate-nativex::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dnsupdate-nativex']['int_domain']</tt></td>
    <td>String</td>
    <td>the route43 domain name in which to create and maintain a record under.</td>
    <td><tt>nativexintern.com</tt></td>
  </tr>
  <tr>
    <td><tt>['dnsupdate-nativex']['int_zone_id']</tt></td>
    <td>String</td>
    <td>the route53 zone id in which to create and maintain a record under.</td>
    <td><tt>Z1NZHUXT02UQJ</tt></td>
  </tr>
  <tr>
    <td><tt>['dnsupdate-nativex']['record_type']</tt></td>
    <td>String</td>
    <td>the route53 record type to be created e.g. SOA, A, TXT, NS, CNAME, MX, PTR, SRV, SPF, AAAA.</td>
    <td><tt>A</tt></td>
  </tr>
</table>

Usage
-----
#### dnsupdate-nativex::default

Just include `dnsupdate-nativex` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dnsupdate-nativex]"
  ]
}
```

License and Authors
-------------------
Authors: Adrian Herrera

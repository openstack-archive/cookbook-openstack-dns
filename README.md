![Chef OpenStack Logo](https://www.openstack.org/themes/openstack/images/project-mascots/Chef%20OpenStack/OpenStack_Project_Chef_horizontal.png)

Description
===========

This cookbook installs the OpenStack DNS service **Designate** as part of an
OpenStack reference deployment Chef for OpenStack.

https://docs.openstack.org/designate

Requirements
============

- Chef 12 or higher
- chefdk 0.9.0 or higher for testing (also includes berkshelf for cookbook
  dependency resolution)

Platform
========

- ubuntu
- redhat
- centos

Cookbooks
=========

The following cookbooks are dependencies:

- 'openstack-common', '>= 16.0.0'
- 'openstack-identity', '>= 16.0.0'
- 'openstackclient', '>= 0.1.0'

Attributes
==========

Please see the extensive inline documentation in `attributes/*.rb` for
descriptions of all the settable attributes for this cookbook.

Note that all attributes are in the `default['openstack']` "namespace"

The usage of attributes to generate the designate.conf is described in the
openstack-common cookbook.

Recipes
=======

## openstack-dns::api
- Configure and start designate-api service

## openstack-dns::client
- Install the designate client package

## openstack-dns::common
- Installs the designate packages and setup configuration for Designate.

## openstack-dns::identity_registration
- Registers the Designate API endpoint, designate service and user

License and Author
==================

|                      |                                                    |
|:---------------------|:---------------------------------------------------|
| **Author**           |  Dr. Jens Harbott (<j.harbott@x-ion.de>)           |
|                      |                                                    |
| **Copyright**        |  Copyright (c) 2017, x-ion GmbH.                   |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

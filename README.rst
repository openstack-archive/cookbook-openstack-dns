OpenStack Chef Cookbook - dns
=============================

.. image:: https://governance.openstack.org/badges/cookbook-openstack-dns.svg
    :target: https://governance.openstack.org/reference/tags/index.html

Description
===========

This cookbook installs the OpenStack DNS service **Designate** as part
of an OpenStack reference deployment Chef for OpenStack.  The `OpenStack
chef-repo`_ contains documentation for using this cookbook in the
context of a full OpenStack deployment. Designate is currently installed
from packages.

.. _OpenStack chef-repo: https://opendev.org/openstack/openstack-chef

https://docs.openstack.org/designate/latest/

Requirements
============

- Chef 16 or higher
- Chef Workstation 21.10.640 for testing (also includes Berkshelf for
  cookbook dependency resolution)

Platform
========

-  ubuntu
-  redhat
-  centos

Cookbooks
=========

The following cookbooks are dependencies:

-  'openstackclient'
-  'openstack-common', '>= 20.0.0'
-  'openstack-identity', '>= 20.0.0'
-  'openstack-network', '>= 20.0.0'

Attributes
==========

Please see the extensive inline documentation in ``attributes/*.rb`` for
descriptions of all the settable attributes for this cookbook.

Note that all attributes are in the ``default['openstack']`` "namespace"

The usage of attributes to generate the ``designate.conf`` is described
in the openstack-common cookbook.

Recipes
=======

openstack-dns::api
------------------

- Configure and start designate-api service

openstack-dns::central
----------------------

- Starts and enables the designate-central service

openstack-dns::common
---------------------

- Installs the designate packages and setup configuration for Designate.

openstack-dns::dashboard
------------------------

- Installs the designate dashboard packages.

openstack-dns::identity_registration
------------------------------------

- Registers the Designate API endpoint, designate service and user

openstack-dns::mdns
-------------------

- Starts and enables the designate-mdns service

openstack-dns::neutron_int
--------------------------

- Configure the neutron external dns driver

openstack-dns::producer
-----------------------

- Starts and enables the designate-producer service

openstack-dns::sink
-------------------

- Starts and enables the designate-sink service

openstack-dns::worker
---------------------

- Starts and enables the designate-worker service

License and Author
==================

+-----------------+-----------------------------------------+
| **Author**      | Dr. Jens Harbott (j.harbott@x-ion.de)   |
+-----------------+-----------------------------------------+
| **Author**      | Jan Klare (j.klare@cloudbau.de)         |
+-----------------+-----------------------------------------+
| **Author**      | Lance Albertson (lance@osuosl.org)      |
+-----------------+-----------------------------------------+

+-----------------+--------------------------------------------------+
| **Copyright**   | Copyright (c) 2017-2019, x-ion GmbH.             |
+-----------------+--------------------------------------------------+
| **Copyright**   | Copyright (c) 2017, cloudbau GmbH.               |
+-----------------+--------------------------------------------------+
| **Copyright**   | Copyright (c) 2019-2021, Oregon State University |
+-----------------+--------------------------------------------------+

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

::

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

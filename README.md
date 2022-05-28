# DatingLibre

[![Workflow status](https://github.com/datinglibre/datinglibre/actions/workflows/datinglibre.yml/badge.svg?branch=master)](https://github.com/datinglibre/DatingLibre/actions)

[DatingLibre](https://datinglibre.com) is an open source white-label dating site platform (implemented as a Symfony bundle). It uses: 
- `PHP` 8.1,
- Symfony 5.4 LTS,
- Ubuntu 22.04 LTS,
- PostgreSQL,
- Amazon `SES`,
- Amazon `S3` (or a compatible service),
- Ansible.

DatingLibre is made up of the following repositories:
- the reference implementation (this repository) which uses the test categories `color` and `shape`, and contains the Gherkin test scenarios.
- the [datinglibre-app-bundle](https://github.com/datinglibre/datinglibre-app-bundle) which contains controllers, repositories, services, entities, database migrations and Behat test contexts.
- the [DatingLibreDemo](https://github.com/datinglibre/DatingLibreDemo) repository, which shows how the `datinglibre-app-bundle` can be 
overridden to build a custom website: overriding functionality as required, whilst leaving the rest of the bundle upgradable via `composer update`. The code in this repository is deployed to the live test site, which can be seen at [datinglibre.com](https://datinglibre.com). You can use this project as a template.

## Documentation

- [User guide](https://github.com/datinglibre/DatingLibre/wiki#user-guide).
- [Developer guide](https://github.com/datinglibre/DatingLibre/wiki#developer-guide). Start with the [Development](https://github.com/datinglibre/DatingLibre/wiki/Development) section to set up the project on a local machine.
- [Upgrading](https://github.com/datinglibre/datinglibre-app-bundle/blob/master/UPGRADING.md).

## Features

- [Automated deployment using Ansible](https://github.com/datinglibre/DatingLibre/wiki/Deploy-production)
- Register account, with a private reminder if an email address already exists.
- Payment providers: [CCBill](https://github.com/datinglibre/datinglibre-ccbill-bundle), [Verotel](https://github.com/datinglibre/datinglibre-verotel-bundle/).
- Confirm account through email.
- Reset password.
- Create a profile.
- Upload a profile image.
- Search by radius and/or region, through a provided [dataset](https://github.com/datinglibre/locations) of the latitudes and longitudes of the world's significant towns and cities.
- Search by interest.  
- Browse through profiles, using keyset pagination.
- Block users.
- Report users.
- Moderate user reports.
- Suspend users.  
- Moderate profile images.
- Delete account.
- Change language.

![Image showing user profile](https://raw.githubusercontent.com/wiki/datinglibre/DatingLibre/images/datinglibre_user.png "Profile page")

![Image showing admin user view](https://raw.githubusercontent.com/wiki/datinglibre/DatingLibre/images/datinglibre_admin.png "Admin page")


## Credits

The `countries.sql` `regions.sql` and `cities.sql` files were created by processing geographical data from [GeoNames](https://www.geonames.org/)
and are licensed under [Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

## Licence

Copyright 2020-2022 DatingLibre.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

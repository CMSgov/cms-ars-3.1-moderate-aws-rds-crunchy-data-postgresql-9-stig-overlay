# cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
InSpec profile overlay to validate the secure configuration of AWS RDS PostgreSQL 9 against [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) PostgreSQL 9.x STIG Version 1 Release 4 tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

## Getting Started
It is intended and recommended that InSpec run this profile from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __ssh__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

The latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

The following attributes must be configured in an attributes file for the profile to run correctly. More information about InSpec attributes can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
pg_owner: 'postgres'
pg_group: 'postgres'
pg_owner_password: ''

pg_dba: 'root'
pg_dba_password: 'password'

pg_user: ''
pg_user_password: ''

pg_host: ''
pg_port: '5432'

pg_db: 'test'
pg_table: ''

# priv user account that can login to the postgres host
login_user: ''
login_host: ''

pg_version: '9.5'

pg_data_dir: "/var/lib/pgsql/9.5/data"
pg_conf_file: "/var/lib/pgsql/9.5/data/postgresql.conf"
pg_user_defined_conf: "/var/lib/pgsql/9.5/data/stig-postgresql.conf"
pg_hba_conf_file: "/var/lib/pgsql/9.5/data/pg_hba.conf"
pg_ident_conf_file: "/var/lib/pgsql/9.5/data/pg_ident.conf"

pg_shared_dirs: [
  "/usr/pgsql-9.5",
  "/usr/pgsql-9.5/bin",
  "/usr/pgsql-9.5/lib",
  "/usr/pgsql-9.5/share"
  ]

pg_conf_mode: '0600'
pg_ssl: 'on'
pg_log_dest: 'syslog'
pg_syslog_facility: ['local0']
pg_syslog_owner: 'postgres'

pgaudit_log_items: ['ddl','role','read','write']
pgaudit_log_line_items: ['%m','%u','%c']

pg_superusers: [
  'postgres',
  ]

pg_users: [
  '',
  ]

pg_replicas: [
  '192.168.1.3/32',
  ]

pg_max_connections: '100'

pg_timezone: 'UTC'
```

## Running This Overlay
When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/mitre/aws-rds-crunchy-data-postgresql-9-stig-baseline.git
git clone https://github.cms.gov/ispg/cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay.git
cd cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
bundle install
cd ..
inspec exec cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay --attrs=<path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd profiles/aws-rds-crunchy-data-postgresql-9-stig-baseline.git
git pull
cd ../cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
git pull
bundle install
cd ..
inspec exec cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay --attrs=<path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

## Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://mitre.github.io/heimdall-lite/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Getting Help
To report a bug or feature request, please open an [issue](https://github.cms.gov/ispg/cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay/issues/new).

## Authors
* Eugene Aronne
* Danny Haynes

## Special Thanks
* Aaron Lippold

## License
* This project is licensed under the terms of the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

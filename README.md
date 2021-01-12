# cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
InSpec profile overlay to validate the secure configuration of AWS RDS PostgreSQL 9 against [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) PostgreSQL 9.x STIG Version 1 Release 1 tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

## Getting Started
It is intended and recommended that InSpec run this profile from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

The latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Tailoring to Your Environment
The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
# Description: 'Postgres OS user (e.g., 'postgres').'
pg_owner: 'postgres'

# Description: 'Postgres OS group (e.g., 'postgres').'
pg_group: 'postgres'

# Description: 'Postgres OS user password'
pg_owner_password: ''

# Description: 'Postgres database admin user (e.g., 'root').'
pg_dba: 'root'

# Description: 'Postgres database admin password ('password').'
pg_dba_password: 'password'

# Description: 'Postgres normal user'
pg_user: ''

# Description: 'Postgres normal user password'
pg_user_password: ''

# Description: 'Postgres database hostname'
pg_host: ''

# Description: 'Postgres database port'
pg_port: '5432'

# Description: 'Postgres database name ('test')'
pg_db: 'test'

# Description: 'Postgres database table name'
pg_table: ''

# Description: 'User on remote database server'
login_user: ''

# Description: 'Database host ip'
login_host: ''

# Description: 'Database version'
pg_version: '9.5'

# Description: 'Data directory for database (e.g., '/var/lib/pgsql/9.5/data')'. 
pg_data_dir: ''

# Description: 'Configuration file for the database ('/var/lib/pgsql/9.5/data/postgresql.conf').'
pg_conf_file: ''

# Description: 'User defined configuration file for the database (e.g., '/var/lib/pgsql/9.5/data/stig-postgresql.conf')'.
pg_user_defined_conf: ''

# Description: 'Configuration file to enable client authentication (e.g., '/var/lib/pgsql/9.5/data/pg_hba.conf')'.
pg_hba_conf_file: ''

# Description: 'Configuration file that maps operating system usernames and database usernames (e.g., '/var/lib/pgsql/9.5/data/pg_ident.conf').'
pg_ident_conf_file: ''

# Description: 'List of shared directories (e.g., pg_shared_dirs: ['/usr/pgsql-9.5', '/usr/pgsql-9.5/bin', '/usr/pgsql-9.5/lib', '/usr/pgsql-9.5/share']).'
pg_shared_dirs: []

# Description: 'Database configuration mode (e.g., 0600)'
pg_conf_mode: '0600'

# Description: 'Postgres ssl setting (e.g., 'on').'
pg_ssl: ''

# Description: 'Postgres log destination (e.g., 'syslog').'
pg_log_dest: ''

# Description: 'Postgres syslog facility (e.g., ['local0']).'
pg_syslog_facility: []

# Description: 'Postgres syslog owner (e.g., 'postgres').'
pg_syslog_owner: ''

# Description: 'Postgres audit log items (e.g., ['ddl','role','read','write']).'
pgaudit_log_items: []

# Description: 'Postgres audit log line items (e.g. ['%m','%u','%c']).'
pgaudit_log_line_items: []

# Description: 'Postgres super users (e.g., ['postgres']).'
pg_superusers: []

# Description: 'Postgres users'
pg_users: []

# Description: 'Postgres replicas (e.g. ['192.168.1.3/32']).'
pg_replicas: []

# Description: 'Postgres max number of connections allowed (e.g., 100).'
pg_max_connections: 0

# Description: 'Postgres timezone (e.g., 'UTC').'
pg_timezone: ''
```

## Running This Overlay Directly from Github

```
# How to run
inspec exec https://github.com/CMSgov/cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay/archive/master.tar.gz --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Overlay from a local Archive copy 

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this overlay and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/CMSgov/cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay.git
inspec archive cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
inspec exec <name of generated archive> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
git pull
cd ..
inspec archive cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay --overwrite
inspec exec <name of generated archive> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

## Using Heimdall for Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.mitre.org/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Eugene Aronne - [ejaronne](https://github.com/ejaronne)
* Danny Haynes - [djhaynes](https://github.com/djhaynes)

## Special Thanks
* Aaron Lippold - [aaronlippold](https://github.com/aaronlippold)
* Shivani Karikar - [karikarshivani](https://github.com/karikarshivani)

## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.com/CMSgov/cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay/issues/new).

### NOTICE

© 2018-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE 

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE 

DISA STIGs are published by DISA IASE, see: https://iase.disa.mil/Pages/privacy_policy.aspx

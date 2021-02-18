# cms-ars-3.1-moderate-aws-rds-crunchy-data-postgresql-9-stig-overlay
InSpec profile overlay to validate the secure configuration of AWS RDS PostgreSQL 9 against [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) PostgreSQL 9.x STIG Version 1 Release 1 tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

## Getting Started
### InSpec (CINC-auditor) setup
For maximum flexibility/accessibility, we’re moving to “cinc-auditor”, the open-source packaged binary version of Chef InSpec, compiled by the CINC (CINC Is Not Chef) project in coordination with Chef using Chef’s always-open-source InSpec source code. For more information: https://cinc.sh/

It is intended and recommended that CINC-auditor and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target. This can be any Unix/Linux/MacOS or Windows runner host, with access to the Internet.

__For the best security of the runner, always install on the runner the _latest version_ of CINC-auditor.__ 

__The simplest way to install CINC-auditor is to use this command for a UNIX/Linux/MacOS runner platform:__
```
curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor
```

__or this command for Windows runner platform (Powershell):__
```
. { iwr -useb https://omnitruck.cinc.sh/install.ps1 } | iex; install -project cinc-auditor
```
To confirm successful install of cinc-auditor:
```
cinc-auditor -v
```
> sample output:  _4.24.32_

Latest versions and other installation options are available at https://cinc.sh/start/auditor/.

### PSQL client setup

To run the PostgreSQL profile against an AWS RDS Instance, CINC-auditor expects the psql client to be readily available on the same runner system it is installed on.
 
For example, to install the psql client on a Linux runner host:
```
sudo yum install postgresql
```
To confirm successful install of psql:
```
which psql
```
> sample output:  _/usr/bin/psql_
```
psql –-version
```		
> sample output:  *psql (PostgreSQL) 9.2.24*

Test psql connectivity to your instance from your runner host:
```
psql -d postgresql://<master user>:<password>@<endpoint>.amazonaws.com/postgres
```		
> *sample output:*
> 
>  *psql (9.2.24, server 9.6.15)*
>  
>  *WARNING: psql version 9.2, server version 9.6.*
>  
>  *SSL connection (cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256)*
>  
>  *Type "help" for help.*
>  
>  *postgres-> \conninfo*
>  
>  *You are connected to database "postgres" as user "postgres" on host "(endpoint).us-east-1.rds.amazonaws.com" at port "5432".*
>  
>  *postgres=> \q*
>  
>  *$*

For installation of psql client on other operating systems for your runner host, visit https://www.postgresql.org/

## Inputs: Tailoring your scan to Your Environment

The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

#### *Note* Windows and Linux InSpec Runner

There are current issues with how the profiles run when using a windows or linux runner. We have accounted for this in the profile with the `windows_runner` input - which we *default* to `false` assuming a Linux based InSpec runner.

If you are using a *Windows* based inspec installation, please set the `windows_runner` input to `true` either via your `inspec.yml` file or via the cli flag via, `--input windows_runner=true`

### Example Inputs You Can Use

```
# Windows or Linux Runner (default value = false)
windows_runner: false



# Description: 'Postgres database admin user (e.g., 'root').'
pg_dba: 'root'

# Description: 'Postgres database admin password ('password').'
pg_dba_password: 'password'

# Description: 'Postgres database hostname'
pg_host: ''

# Description: 'Postgres database name ('test')'
pg_db: 'test'

# Description: 'Postgres database port'
pg_port: '5432'



# Description: 'Postgres super users (e.g., ['postgres']).'
pg_superusers: []

# Description: 'Postgres users'
pg_users: []

# Description: 'Postgres normal user'
pg_user: ''

# Description: 'Postgres normal user password'
pg_user_password: ''

# Description: 'Postgres database table name'
pg_table: ''

# Description: 'User on remote database server'
login_user: ''

# Description: 'Database host ip'
login_host: ''

# Description: 'Database version' (default 9.5)
pg_version: '9.5'

# Description: 'Postgres ssl setting (e.g., 'on').'
pg_ssl: ''

# Description: 'Postgres audit log items (e.g., ['ddl','role','read','write']).'
pgaudit_log_items: []

# Description: 'Postgres audit log line items (e.g. ['%m','%u','%c']).'
pgaudit_log_line_items: []

# Description: 'Postgres replicas (e.g. ['192.168.1.3/32']).'
pg_replicas: []

# Description: 'Postgres max number of connections allowed (e.g., 100).'
pg_max_connections: 100

# Description: 'Postgres timezone (e.g., 'UTC').'
pg_timezone: 'UTC'
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

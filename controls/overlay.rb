# encoding: utf-8

include_controls 'pgstigcheck-inspec' do
  control 'V-72857' do
    desc 'The CMS standard for authentication is CMS-approved 
         PKI certificates. 

         Authentication based on User ID and Password may be 
         used only when it is not possible to employ a PKI 
         certificate, and requires AO approval.

         In such cases, passwords need to be protected at all 
         times, and encryption is the standard method for 
         protecting passwords during transmission.

         PostgreSQL passwords sent in clear text format across 
         the network are vulnerable to discovery by unauthorized 
         users. Disclosure of passwords may easily lead to 
         unauthorized access to the database.'
  end

  control 'V-72859' do
    desc 'Authentication with a CMS-approved PKI certificate does 
         not necessarily imply authorization to access PostgreSQL. 
         To mitigate the risk of unauthorized access to sensitive 
         information by entities that have been issued certificates 
         by CMS-approved PKIs, all CMS systems, including databases, 
         must be properly configured to implement access control 
         policies.

         Successful authentication must not automatically give an 
         entity access to an asset or security boundary. 
         Authorization procedures and controls must be implemented 
         to ensure each authenticated entity also has a validated 
         and current authorization. Authorization is the process 
         of determining whether an entity, once authenticated, is 
         permitted to access a specific asset. Information systems 
         use access control policies and enforcement mechanisms to 
         implement this requirement.

         Access control policies include identity-based policies, 
         role-based policies, and attribute-based policies. Access 
         enforcement mechanisms include access control lists, 
         access control matrices, and cryptography. These policies 
         and mechanisms must be employed by the application to 
         control access between users (or processes acting on behalf 
         of users) and objects (e.g., devices, files, records, 
         processes, programs, and domains) in the information system.

         This requirement is applicable to access control enforcement   
         applications, a category that includes database management 
         systems. If PostgreSQL does not follow applicable policy when 
         approving access, it may be in conflict with networks or other 
         applications in the information system. This may result in 
         users either gaining or being denied access inappropriately 
         and in conflict with applicable policy.'
  end

  control 'V-72863' do
    impact 'none'
    desc 'caveat', 'Not applicable for this CMS ARS 3.1 overlay, 
    since the related security control is not applied to this 
    system categorization in CMS ARS 3.1'
  end

  control 'V-72961' do
    desc 'For completeness of forensic analysis, it is necessary to 
         track who logs on to PostgreSQL.

         Concurrent connections by the same user from multiple 
         workstations may be valid use of the system; or such 
         connections may be due to improper circumvention of the        
         requirement to use the CAC/PIV for authentication; or they may 
         indicate unauthorized account sharing; or they may be because 
         an account has been compromised.

         (If the fact of multiple, concurrent logons by a given user 
         can be reliably reconstructed from the log entries for other 
         events (logons/connections; voluntary and involuntary 
         disconnections), then it is not mandatory to create additional 
         log entries specifically for this.)'
  end

  control 'V-72979' do
    desc 'The CMS standard for authentication is CMS-approved PKI 
         certificates.

         A certificate certification path is the path from the end 
         entity certificate to a trusted root certification authority 
         (CA). Certification path validation is necessary for a relying 
         party to make an informed decision regarding acceptance of an 
         end entity certificate. Certification path validation includes 
         checks such as certificate issuer trust, time validity and 
         revocation status for each certificate in the certification 
         path. Revocation status information for CA and subject 
         certificates in a certification path is commonly provided via 
         certificate revocation lists (CRLs) or online certificate 
         status protocol (OCSP) responses.

         Database Management Systems that do not validate certificates 
         by performing RFC 5280-compliant certification path validation 
         are in danger of accepting certificates that are invalid and/or 
         counterfeit. This could allow unauthorized access to the database.'
  end

  control 'V-72983' do
    title 'PostgreSQL must provide audit record generation capability 
          for CMS-defined auditable events within all DBMS/database 
          components.'
    desc 'Without the capability to generate audit records, it would 
         be difficult to establish, correlate, and investigate the events 
         relating to an incident or identify those responsible for one. 

         Audit records can be generated from various components within 
         PostgreSQL (e.g., process, module). Certain specific application 
         functionalities may be audited as well. The list of audited events 
         is the set of events for which audits are to be generated. This 
         set of events is typically a subset of the list of all events for 
         which the system is capable of generating audit records.

         CMS has defined the list of events for which PostgreSQL will 
         provide an audit record generation capability as the following: 

         (i) Successful and unsuccessful attempts to access, modify, or 
         delete privileges, security objects, security levels, or categories 
         of information (e.g., classification levels);
         (ii) Access actions, such as successful and unsuccessful logon 
         attempts, privileged activities, or other system-level access, 
         starting and ending time for user access to the system, concurrent 
         logons from different workstations, successful and unsuccessful 
         accesses to objects, all program initiations, and all direct 
         access to the information system; and
         (iii) All account creation, modification, disabling, and 
         termination actions.

         Organizations may define additional events requiring continuous 
         or ad hoc auditing.'
    desc 'fix', 'Configure PostgreSQL to generate audit records for at 
         least the CMS minimum set of events.

         Using pgaudit PostgreSQL can be configured to audit these 
         requests. See supplementary content APPENDIX-B for documentation 
         on installing pgaudit.

         To ensure that logging is enabled, review supplementary content 
         APPENDIX-C for instructions on enabling logging.'
  end

  control 'V-72991' do
    title 'PostgreSQL must use CMS-approved cryptography to protect 
    classified sensitive information in accordance with the data owners 
    requirements.'
    desc 'Use of weak or untested encryption algorithms undermines the 
    purposes of utilizing encryption to protect data. The application 
    must implement cryptographic modules adhering to the higher standards 
    approved by the federal government since this provides assurance 
    they have been tested and validated.

    It is the responsibility of the data owner to assess the cryptography 
    requirements in light of applicable federal laws, Executive Orders, 
    directives, policies, regulations, and standards.'
    desc 'check', 'If PostgreSQL is not using CMS-approved cryptography 
    to protect classified sensitive information in accordance with 
    applicable federal laws, Executive Orders, directives, policies, 
    regulations, and standards, this is a finding.

    To check if PostgreSQL is configured to use SSL, as the database 
    administrator (shown here as "postgres"), run the following SQL:

    $ sudo su - postgres
    $ psql -c "SHOW ssl"

    If SSL is off, this is a finding.'
    desc 'fix', 'Note: The following instructions use the PGDATA 
    environment variable. See supplementary content APPENDIX-F for 
    instructions on configuring PGDATA.

    To configure PostgreSQL to use SSL, as a database administrator 
    (shown here as "postgres"), edit postgresql.conf:

    $ sudo su - postgres
    $ vi ${PGDATA?}/postgresql.conf

    Add the following parameter:

    ssl = on

    Now, as the system administrator, reload the server with the 
    new configuration:

    # SYSTEMD SERVER ONLY
    $ sudo systemctl reload postgresql-9.5

    # INITD SERVER ONLY
    $ sudo service postgresql-9.5 reload

    For more information on configuring PostgreSQL to use SSL, see 
    supplementary content APPENDIX-G.'
  end

  control 'V-73015' do
    desc 'The CMS standard for authentication is CMS-approved PKI 
         certificates.
         
         Authentication based on User ID and Password may be used only 
         when it is not possible to employ a PKI certificate, and 
         requires AO approval.

         In such cases, database passwords stored in clear text, using 
         reversible encryption, or using unsalted hashes would be 
         vulnerable to unauthorized disclosure. Database passwords must 
         always be in the form of one-way, salted hashes when stored 
         internally or externally to PostgreSQL.'
  end

  control 'V-73023' do
    title 'The system must provide a warning to appropriate support 
          staff when allocated audit record storage volume reaches 80% 
          of maximum audit record storage capacity.'
    desc 'Organizations are required to use a central log management system, 
         so, under normal conditions, the audit space allocated to 
         PostgreSQL on its own server will not be an issue. However, 
         space will still be required on PostgreSQL server for audit 
         records in transit, and, under abnormal conditions, this could 
         fill up. Since a requirement exists to halt processing upon 
         audit failure, a service outage would result.

         If support personnel are not notified immediately upon storage 
         volume utilization reaching 80%, they are unable to plan for   
         storage capacity expansion. 

         The appropriate support staff include, at a minimum, the ISSO 
         and the DBA/SA.'
    desc 'check', 'Review system configuration.

         If no script/tool is monitoring the partition for the PostgreSQL 
         log directories, this is a finding.

         If appropriate support staff are not notified immediately upon 
         storage volume utilization reaching 80%, this is a finding.'

    desc 'fix', 'Configure the system to notify appropriate support 
         staff immediately upon storage volume utilization reaching 80%.

         PostgreSQL does not monitor storage, however, it is possible to 
         monitor storage with a script.

         ##### Example Monitoring Script

         #!/bin/bash

         PGDATA=/var/lib/psql/9.5/data
         CURRENT=$(df ${PGDATA?} | grep / | awk "{ print $5}" 
                                 | sed "s/%//g")
         THRESHOLD=80

         if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
         mail -s "Disk Space Alert" mail@support.com << EOF
         The data directory volume is almost full. Used: $CURRENT
         %EOF
         fi

         Schedule this script in cron to run around the clock.'
  end

  control 'V-73027' do
    desc 'The CMS standard for authentication of an interactive user 
         is the presentation of a Personal Identity Verification (PIV) 
         Card or other physical token bearing a valid, current, 
         CMS-issued Public Key Infrastructure (PKI) certificate, coupled 
         with a Personal Identification Number (PIN) to be entered by 
         the user at the beginning of each session and whenever 
         reauthentication is required.

         Without reauthentication, users may access resources or perform 
         tasks for which they do not have authorization.

         When applications provide the capability to change security 
         roles or escalate the functional capability of the application, 
         it is critical the user re-authenticate.

         In addition to the reauthentication requirements associated with 
         session locks, organizations may require reauthentication of 
         individuals and/or devices in other situations, including (but 
         not limited to) the following circumstances:

         (i) When authenticators change;
         (ii) When roles change;
         (iii) When security categorized information systems change;
         (iv) When the execution of privileged functions occurs;
         (v) After a fixed period of time; or
         (vi) Periodically.

         Within CMS, the minimum circumstances requiring reauthentication 
         are privilege escalation and role changes.'
  end

  control 'V-73029' do
    desc 'The CMS standard for authentication is CMS-approved PKI 
         certificates. PKI certificate-based authentication is performed 
         by requiring the certificate holder to cryptographically prove 
         possession of the corresponding private key.

         If the private key is stolen, an attacker can use the private 
         key(s) to impersonate the certificate holder. In cases where 
         PostgreSQL-stored private keys are used to authenticate PostgreSQL 
         to the system, clients, loss of the corresponding private keys 
         would allow an attacker to successfully perform undetected 
         man-in-the-middle attacks against PostgreSQL system and its    
         clients.

         Both the holder of a digital certificate and the issuing authority 
         must take careful measures to protect the corresponding private 
         key. Private keys should always be generated and protected in 
         FIPS 140-2 validated cryptographic modules.

         All access to the private key(s) of PostgreSQL must be restricted 
         to authorized and authenticated users. If unauthorized users have 
         access to one or more of PostgreSQL\'s private keys, an attacker 
         could gain access to the key(s) and use them to impersonate the 
         database on the network or otherwise perform unauthorized actions.'
  end

  control 'V-73031' do
    title 'PostgreSQL must only accept end entity certificates issued by 
          CMS PKI or CMS-approved PKI Certification Authorities (CAs) for 
          the establishment of all encrypted sessions.'
    
    desc 'Only CMS-approved external PKIs have been evaluated to ensure 
         that they have security controls and identity vetting procedures 
         in place which are sufficient for CMS systems to rely on the 
         identity asserted in the certificate. PKIs lacking sufficient 
         security controls and identity vetting procedures risk being 
         compromised and issuing certificates that enable adversaries to 
         impersonate legitimate users. 

         The authoritative list of CMS-approved PKIs is published at 
         http://iase.disa.mil/pki-pke/interoperability.

         This requirement focuses on communications protection for 
         PostgreSQL session rather than for the network packet.'

    desc 'fix', 'Revoke trust in any certificates not issued by a 
         CMS-approved certificate authority.

         Configure PostgreSQL to accept only CMS and CMS-approved PKI 
         end-entity certificates.

         To configure PostgreSQL to accept approved CA\'s, see the 
         official PostgreSQL documentation: 
         http://www.postgresql.org/docs/current/static/ssl-tcp.html

         For more information on configuring PostgreSQL to use SSL, 
         see supplementary content APPENDIX-G.'
  end

  control 'V-73037' do
    tag "cci": ['CCI-001184']
    tag "nist": ['SC-23', 'Rev_4']
   end

  control 'V-73045' do
    tag	"cci": ['CCI-001848']
    tag "nist": ['AU-4', 'Rev_4']
  end

  control 'V-73051' do
    describe 'For this CMS ARS 3.1 overlay, this control must be reviewed manually' do 
      skip 'For this CMS ARS 3.1 overlay, this control must be reviewed manually'
    end
  end

  control 'V-73055' do
    desc 'The CMS standard for authentication is CMS-approved PKI 
         certificates. Once a PKI certificate has been validated, it 
         must be mapped to PostgreSQL user account for the authenticated 
         identity to be meaningful to PostgreSQL and useful for 
         authorization decisions.'
  end
end

This is hivedump, by Jonathan Roach.

It offers a reliable way to dump the SAM, Cached passwords, LSA secrets
and, if available, the Active Directory database from Windows servers.

The SAM, SECURITY and SYSTEM registry hives and NTDS.dit are retrieved
into your current working directory in Linux, and the remote host is
then cleaned up.

The Volume Shadow Copy service is used to retrieve NTDS.dit. If there
is an existing VSS volume set up for the drive on which NTDS.dit is located,
then that is used. If there is not an existing appropriate VSS volume,
a new one is created and then deleted after the copy operation.

You don't mess about with uploading/downloading tools. It's all done for you,
and the results are delivered right into your current working directory for
import into creddump and NTDSXtract, and from there into john, ophcrack,
rcrack or your other favourite cracker.

To install hivedump, simply run the install.sh script as root.

USAGE
=====
hivedump <host> <username> <password>

Example (note the escaping of the shell metacharacters):
hivedump 192.168.1.1 Administrator \"c0mpL3xP@\$\$word

Bug reports and feature requsts to jonnyhightower [at] funkygeek.com

Installation
============
In this directory, run ./install.sh as root.





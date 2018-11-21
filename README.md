json2mysql
==========

JSON to database import tool with support for PHP serialization.

### About

This command line tool will import the specified JSON file created from the companion tool [mysql2json](https://github.com/steveorevo/mysql2json). Auto-detection of objects will be stored as PHP serialized strings.  

#### Help
Type json2mysql --help

```
JSON2MySQL is a JSON import tool with support for PHP serialization.
Version 1.0.0

Usage: json2mysql [-?, --help] [-h host, --hose host (default: localhost)] [-l, --list] [-p password, --password password] [-P port, --port port] [-q quiet, --quiet quiet] [-t tables, --tables tables] [-u user, --user user (default: root)] [-v, --version] [json_file]

Optional Arguments:
	-?, --help
		print this help
	-h host, --hose host (default: localhost)
		host name or IP address (default: localhost)
	-l, --list
		list tables available for import
	-p password, --password password
		password to connect with (default is none)
	-P port, --port port
		the TCP/IP port number to connect to
	-t tables, --tables tables
		a comma delimited list of tables (default empty for all)
	-u user, --user user (default: root)
		username to connect as (default: root)
	-q quiet, --quiet quiet
		quiet (no output)
	-v, --version
		output version number
	json_file
		the json file to import
```

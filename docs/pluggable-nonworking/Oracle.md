# Oracle Express 18 for Windows
(C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Oracle - OraDB18Home1)

## "Oracle Database Express Edition on Windows - Installing and Getting Started"
(https://www.youtube.com/watch?v=wiEsR_j36yw)
* Open "SQL Plus"
* Enter user-name: `/ as sysdba`
* `alter pluggable database all open;`
* `alter pluggable database all save state;` ensures that the pluggable database will open when the service starts.
* View users: `select name from v$pdbs;`
* Connect (default password is oracle): `connect sys/oracle@localhost:1521/XEPDB1 as sysdba;`

### Tests
* Unlock example user "hr" to manipulate the example "hr" database:
  `alter user hr account unlock;`
* Connect to the example database:
  `connect hr/hr@localhost:1521/XEPDB1;`
* Test: `select * from employees`
* Start and stop database using Services snap-in: "OracleServiceXE"
  - Right-click "OracleServiceXE," click Properties, choose Automatic or Manual.


## Application Development
### SQL Plus
(See above)

## SQL Developer
(downloaded separately)
See README.md.

## Configuration and Migration Tools
(C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Oracle - OraDB18Home1\Configuration and Migration Tools)

### Database Configuration Assistant
Global database name: orcl
* "[INS-08101] Unexpected error while executing the action at state: 'summaryPage'"
* "java.lang.NullPointerException"

### Update Password for Oracle Home User
* "OHUC-1030 : user is Virtual Account"

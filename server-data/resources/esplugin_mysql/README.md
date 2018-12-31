# esplugin_mysql

An MySQL plugin for [EssentialMode](https://github.com/kanersps/essentialmode).

## Installation

- Download [esplugin_mysql](https://github.com/kanersps/esplugin_mysql/archive/master.zip)
- Make sure you have [mysql-async](https://github.com/brouznouf/fivem-mysql-async) installed and working
- Import the SQL file provided with this project, `esplugin_mysql.sql`
- Add the following convar in your server configuration file: `set es_enableCustomData 1`. Make sure you put it directly under `mysql_connection_string`
- Make your load order is correct. Here's how it should look:

```bash
start mysql-async
start essentialmode
start esplugin_mysql
```
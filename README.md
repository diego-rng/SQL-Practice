# SQL-Practice

This is a project made mainly to practice SQL, mainly based around the LinkedIn data architecture.

## Requirements

This project requires Docker Desktop version 4.68.0 or higher, any IDE capable of parsing / interacting with SQL and Git version 2.54.0 or later.

## Setup

To set up the project for your own use, start by opening any CLI (Bash is recommended) and input the following:

```
git clone https://github.com/diego-rng/SQL-Practice.git
```

After that, swap to the directory within the CLI (the commands are different for every CLI, I will be using the bash default commands.)

```
cd SQL-Practice/
```

When within the directory, use docker to create a new container with MSSQL as its basis by using:

```
docker compose up -d
```

If used within the directory, this will create the container with the correct settings. If you want to change anything, you can edit the `docker-compose.yml` file included in the directory.

To make sure that the container is up and running, you should use the following command:

```
docker ps
```

And you should see something along the lines of: 

```
CONTAINER ID   IMAGE                                        COMMAND                  CREATED        STATUS        PORTS                                         NAMES
11b84f54f437   mcr.microsoft.com/mssql/server:2022-latest   "/opt/mssql/bin/laun…"   1 minute ago   Up 1 second   0.0.0.0:1433->1433/tcp, [::]:1433->1433/tcp   sqlserver

```

If you don't see anything, you might've missed a step.


Once the docker container is up and running, it's time to start populating it

To do that, you will use the `.bak` file provided.

Use the following command:

```
docker cp '(Path to your default folder)\SQL-Practice\linkedin_db_full.bak' sqlserver:var/opt/mssql/backups/in/linkedin_db_full.bak
```

And you should get the following return:

``` 
Successfully copied 7.55MB to sqlserver:var/opt/mssql/backups/in/linkedin_db_full.bak
``` 

After this, let's swap to your IDE of choice.

For this example, I will be using VSCode with the MSSQL recommended extensions.

To connect to the database, find the SQL Server Badge on the sidebar, hover the 'Connections' tab and click on Add Connection. 

It's not necessary to name the profile you're going to use. The only fields you need to fill are the ones with a red asterisk next to them. 

On the Server Name field, input `localhost, 1433`.

On the Authentication Type field, make sure to check that `SQL Login` is the marked option.

For the User Name field, type in `SA` or whatever you set the user name as, if you modified the `docker-compose.yml` file.

For the Password field, type in `UberWorkshop@2024` or your own password, if you modified the compose file, like above.

Make sure to check the `Trust server certificate` option if it is unchecked, so you don't have any issues connecting to SQL.

Now, you can just press 'Connect' and VSCode will automatically speak to SQL and start a connection.

### Restoring your files

To restore the files in the database from either the backup mentioned previously or your own, you can use the `Restore-Call.sql` file in the `linkedin_db` folder, and, if needed, modify it to fit your own backup file.

### Backing up your files

To back up your files, use the `Backup-Call.sql` file in the `linkedin_db` folder, and if you want, modify it to keep your backups separate from the one mentioned. To pull the backup file OUT of docker, use the following command:

```
docker cp sqlserver:var/opt/mssql/backups/out/linkedin_db_full.bak '(whatever path you choose)/linkedin_db_full.bak'
```

You may change the names to fit with whatever you want to name your own Backup. Make sure that the Windows path is in quotes, as docker could interpret the filepath as a Linux path otherwise.
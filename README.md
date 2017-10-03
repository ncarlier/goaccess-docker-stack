# GoAccess Docker usage sample

## Description

A simple Docker stack to illustrate the usage of GoAccess with NGINX.

NGINX logs are gathered by Rsyslog in order to be processed by GoAccess.

## Usage

Deploy the stack:

```bash
$ make deploy
```

Do some request on the HTTP server:

```bash
$ for ((i=1;i<=100;i++)); do curl "localhost"; done
```

Generate the static report:

```bash
$ make report
```

You can view the result here: `http://localhost/reports/`


> Use `make help` to see other available commands.

---

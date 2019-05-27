# f-drones-app v0.4

## Flight log drones web application

## Description

Drone flight logger - web application for FPV pilots:

- track drones fleet
- log flights with details

## Requirements

- python3, Flask
- mariadb-server

## Clone repository

```
git clone https://github.com/karcio/f-drones-app.git

```

## DB Configuration steps

```
mysql -u user -ppassword < f-drones-app/static/assets/sql/initdb.sql
```

## create virtual environment and activate

```
cd f-drones-app
python3 -m venv virtenv
source virtenv/bin/activate
```

## install requrements

```
pip install -r requirements.txt
```

## start application

```
python app.py
```

## NOTE: if you want use https instead of http replace following line

```
app.run(debug=False, host='0.0.0.0', port=5000)
```

with

```
app.run(debug=False, host='0.0.0.0', port=5000, ssl_context=('/etc/letsencrypt/live/your-domain/fullchain.pem', '/etc/letsencrypt/live/your-domain/privkey.pem'))
```

## NOTE: to use config make sure you rename config.template to config

```
mv config.template config

```

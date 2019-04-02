# flight log drones web application

## Description

Drone flight logger - web application for FPV pilots:

- track drones fleet
- log flights with details

## Requirements

- python3, Flask
- mysql installed

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

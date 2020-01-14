#!/bin/bash

git clone -b development https://github.com/karcio/f-drones-app.git
cd f-drones-app
mv config.template config
sed -i 's/localhost = localhost/localhost = 10.5.0.6/g' config
sed -i 's/company = your company url/company = staging/g' config
cat config
/usr/bin/python3.5 -m venv virtenv
source virtenv/bin/activate
pip install -r requirements.txt
python app.py
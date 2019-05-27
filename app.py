import os
from flask import Flask, render_template, session, request
from flaskext.mysql import MySQL
import configparser
import logging
logging.basicConfig(
    format=' %(levelname)s - %(asctime)s - %(message)s ', level=logging.DEBUG)

app = Flask(__name__)


config = configparser.ConfigParser()


def getLocalhost():
    readConfig()

    return config.get('MY_SQL', 'localhost')


def getDatabase():
    readConfig()

    return config.get('MY_SQL', 'database')


def getDbPass():
    readConfig()

    return config.get('MY_SQL', 'dbpassword')


def getDbUser():
    readConfig()

    return config.get('MY_SQL', 'dbuser')


def getAppVersion():
    readConfig()

    return config.get('APP', 'version')


def getAppPass():
    readConfig()

    return config.get('APP', 'password')


def getAppUser():
    readConfig()
    return config.get('APP', 'user')


def readConfig():
    property = config.read('../f-drones-app/config')

    return property


mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = getDbUser()
app.config['MYSQL_DATABASE_PASSWORD'] = getDbPass()
app.config['MYSQL_DATABASE_DB'] = getDatabase()
app.config['MYSQL_DATABASE_HOST'] = getLocalhost()
mysql.init_app(app)


@app.route('/', methods=['GET'])
def home():
    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        getAppUser()
        logging.info(getTotalFlights())
        logging.info(getAllFlights2019())
        logging.info(getAllFlights2018())
        logging.info(getDrones())

        return render_template('index.html', rows=getTotalFlights(), version=getAppVersion(), data2018=getAllFlights2018(), data2019=getAllFlights2019(), getDrones=getDrones())


@app.route('/drones', methods=['GET'])
def drones():
    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        logging.info(getDrones())
        return render_template('drones.html', rows=getDrones(), version=getAppVersion())


@app.route('/flightlog', methods=['GET'])
def flightlog():
    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        logging.info(getFlightlog())
        return render_template('flightlog.html', rows=getFlightlog(), version=getAppVersion())


@app.route('/login', methods=['POST'])
def do_admin_login():

    if request.form['password'] == getAppPass() and request.form['username'] == getAppUser():
        session['logged_in'] = True
    else:
        logging.error('wrong password')
    return home()


@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()


@app.route("/insert", methods=['GET', 'POST'])
def insert():
    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        if request.method == 'POST':
            date = request.form['date']
            place = request.form['place']
            droneid = request.form['droneid']
            lipo = request.form['lipo']
            notes = request.form['notes']

            sql = "INSERT INTO FLIGHT_LOG(DATE, PLACE, DRONE_ID, LIPO, NOTES) VALUES('" + \
                str(date)+"', '"+str(place)+"', "+str(droneid) + \
                ", "+str(lipo)+", '"+str(notes)+"')"

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sql)
            conn.commit()
            cursor.close()
            conn.close()

            logging.info('inserted 1 row: ' + sql)

            return render_template('success.html')

        elif request.method == 'GET':
            return render_template('insert.html')


def getAllFlights2018():
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM VIEW_TOTAL_FLIGHTS_2018")
    data2018 = cursor.fetchone()

    return data2018


def getAllFlights2019():
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM VIEW_TOTAL_FLIGHTS_2019")
    data2019 = cursor.fetchone()

    return data2019


def getDrones():

    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM VIEW_DRONES")
    drones = cursor.fetchall()

    return drones


def getTotalFlights():
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * from VIEW_TOTAL_FLIGHTS")
    totalFlights = cursor.fetchone()

    return totalFlights


def getFlightlog():
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * from VIEW_FLIGHT_LOG")
    flightLog = cursor.fetchall()

    return flightLog


if __name__ == '__main__':
    app.secret_key = os.urandom(12)
    app.run(debug=True, host='0.0.0.0', port=5000)
    # SSL
    #app.run(debug=False, host='0.0.0.0', port=5000, ssl_context=('/etc/letsencrypt/live/your-domain/fullchain.pem', '/etc/letsencrypt/live/your-domain/privkey.pem'))

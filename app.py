from flask import Flask, render_template, session, request
from flaskext.mysql import MySQL

import os


app = Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'dbuser'
app.config['MYSQL_DATABASE_PASSWORD'] = 'pa88w0rd'
app.config['MYSQL_DATABASE_DB'] = 'RCDB'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)



@app.route('/', methods=['GET'])
def home():
    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        conn = mysql.connect()
        cursor =conn.cursor()

        cursor.execute("SELECT * from VIEW_TOTAL_FLIGHTS")
        data = cursor.fetchone()  
        print(data)  

        return render_template('index.html', rows = data)


@app.route('/login', methods=['POST'])
def do_admin_login():
    if request.form['password'] == 'pa88w0rd' and request.form['username'] == 'admin':
        session['logged_in'] = True
    else:
        print('wrong password')
    return home()


@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()


@app.route("/insert", methods=['GET', 'POST'])
def insert():

    if request.method == 'POST':
        date = request.form['date']
        place = request.form['place']
        droneid = request.form['droneid']
        lipo = request.form['lipo']
        notes = request.form['notes']
        
        sql = "INSERT INTO FLIGHT_LOG(DATE, PLACE, DRONE_ID, LIPO, NOTES) VALUES('" + \
            str(date)+"', '"+str(place)+"', "+str(droneid) + \
            ", "+str(lipo)+", '"+str(notes)+"')"
        print(sql)

        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute(sql)
        conn.commit()
        cursor.close()
        conn.close()

        print('inserted 1 row: ' + sql)
    return render_template('insert.html')
    


if __name__ == '__main__':
    app.secret_key = os.urandom(12)
    app.run(debug=True, host='0.0.0.0', port=5000)

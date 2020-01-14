import configparser
import logging
logging.basicConfig(
    format=' %(levelname)s - %(asctime)s - %(message)s ', level=logging.DEBUG)

config = configparser.ConfigParser()


class configuration():

    def getYear(self):
        logging.info('Getting year')
        self.readConfig()

        return config.get('FOOTER', 'year')

    def getCompany(self):
        logging.info('Getting company')
        self.readConfig()

        return config.get('FOOTER', 'company')

    def getLocalhost(self):
        logging.info('Getting localhost')
        self.readConfig()

        return config.get('MY_SQL', 'localhost')

    def getDatabase(self):
        logging.info('Getting database')
        self.readConfig()

        return config.get('MY_SQL', 'database')

    def getDbPass(self):
        logging.info('Getting database password')
        self.readConfig()

        return config.get('MY_SQL', 'dbpassword')

    def getDbUser(self):
        logging.info('Getting database user')
        self.readConfig()

        return config.get('MY_SQL', 'dbuser')

    def getAppUrl(self):
        logging.info('Getting application url')
        self.readConfig()

    def getAppVersion(self):
        logging.info('Getting application version')
        self.readConfig()

        return config.get('APP', 'version')

    def getAppPass(self):
        logging.info('Getting application password')
        self.readConfig()

        return config.get('APP', 'password')

    def getAppUser(self):
        logging.info('Getting application user')
        self.readConfig()
        return config.get('APP', 'user')

    def readConfig(self):
        property = config.read('../f-drones-app/config')

        return property

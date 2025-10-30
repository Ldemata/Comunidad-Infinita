import mysql.connector as my
from mysql.connector import Error

try:
    conexionDB = my.connect(
        host = 'localhost',
        port = 3306,
        user = 'root',
        password = 'root',
        db = 'seminariodb'
    )
except:
    print('Error en conexion')
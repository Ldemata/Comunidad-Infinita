from conexion import *

def consultar_publicaciones():
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute("Select * from Publicaciones")
            resultado = cursor.fetchall()
            return resultado
        except:
            print("Error en consulta")

def consultar_votos(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT COUNT(*) AS total_votos FROM votos where IdPublicaion = {id}")
            resultado = cursor.fetchall()
            return resultado[0][0]
        except:
            print("Error en consulta")

def consultar_publicacion(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT * FROM Publicaciones where Id = {id}")
            resultado = cursor.fetchall()
            return resultado[0]
        except:
            print("Error en consulta")

def consultar_usuario(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT Nombre FROM Usuarios where Id = {id}")
            resultado = cursor.fetchall()
            return resultado[0][0]
        except:
            print("Error en consulta")

def consultar_categoria(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT c.categoria FROM publicacionCategoria AS pc JOIN categorias AS c ON pc.idCategoria = c.id WHERE pc.idPublicacion = {id}")
            respuesta = cursor.fetchall()
            resultado = []
            for r in respuesta:
                resultado.append(r[0])
            return resultado
        except:
            print("Error en consulta")

def consultar_documentos(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT * FROM Documentos where IdPublicacion = {id}")
            resultado = cursor.fetchall()
            return resultado
        except:
            print("Error en consulta")

def consultar_imagenes(id):
    if conexionDB.is_connected():
        try:
            cursor = conexionDB.cursor()
            cursor.execute(f"SELECT * FROM Imagenes where IdPublicacion = {id}")
            resultado = cursor.fetchall()
            return resultado
        except:
            print("Error en consulta")

base_publicaciones = []
for data in consultar_publicaciones():
    info = {}
    info['id'] = data[0]
    info['titulo'] = data[1]
    info['contenido'] = data[2]
    info['fechaCreacion'] = data[3].strftime("%d/%m/%Y")
    info['fechaActualizacion'] = data[4].strftime("%d/%m/%Y")
    info['votos'] = consultar_votos(info['id'])
    info['usuario'] = consultar_usuario(data[5])
    base_publicaciones.append(info)
# print(base_publicaciones)
# print(consultar_categoria(1))
# print(consultar_publicacion(1))
print(consultar_imagenes(1))
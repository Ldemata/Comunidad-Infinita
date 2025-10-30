from flask import Flask, request, render_template
from operaciones import *

app = Flask(__name__)

# Ruta a la página de inicio
@app.route('/')
def inicio():
    base_publicaciones = []
    for data in consultar_publicaciones():
        info = {}
        info['id'] = data[0]
        info['titulo'] = data[1]
        info['contenido'] = data[2]
        info['fechaCreacion'] = data[3].strftime("%d/%m/%Y")
        info['fechaActualizacion'] = data[4].strftime("%d/%m/%Y")
        info['votos'] = consultar_votos(data[0])
        info['usuario'] = consultar_usuario(data[5])
        info['categorias'] = consultar_categoria(data[0])
        base_publicaciones.append(info)
    return render_template('inicio.html', base_publicaciones = base_publicaciones)

@app.route('/publicacion')
def publicacion():
    id_publicacion = request.args.get('id')
    if id_publicacion:
        id_publicacion = int(id_publicacion)
    data = consultar_publicacion(id_publicacion)
    info = {}
    info['id'] = data[0]
    info['titulo'] = data[1]
    info['contenido'] = data[2]
    info['fechaCreacion'] = data[3].strftime("%d/%m/%Y")
    info['fechaActualizacion'] = data[4].strftime("%d/%m/%Y")
    info['votos'] = consultar_votos(data[0])
    info['usuario'] = consultar_usuario(data[5])
    info['categorias'] = consultar_categoria(data[0])

    documentos = []
    docs = consultar_documentos(data[0])
    for doc in docs:
        info2 = {}
        info2['id'] = doc[0]
        info2['url'] = doc[1]
        info2['nombre'] = doc[2]
        documentos.append(info2)

    info['documentos'] = documentos
    
    imagenes = []
    imgs = consultar_imagenes(data[0])
    for img in imgs:
        info3 = {}
        info3['id'] = img[0]
        info3['url'] = img[1]
        info3['nombre'] = img[2]
        imagenes.append(info3)

    info['imagenes'] = imagenes

    return render_template('publicacion.html', idPublicacion = id_publicacion, data_publicacion = info)

@app.route('/crear')
def crear():
    return render_template('crear.html')

@app.route('/administrar')
def administrar():
    return render_template('administrar.html')

if __name__ == '__main__':
    app.run(debug=True)

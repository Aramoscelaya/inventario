from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse
from .models import Producto
from .forms import ProductoForm
from pyzbar.pyzbar import decode
from PIL import Image
from io import BytesIO
import base64


def capImgBarCode(request):
    if request.method == 'POST':
        # Obtener la imagen en base64 desde la solicitud POST
        image_data = request.POST.get('image')
        if image_data:
            # Decodificar la imagen
            image_data = base64.b64decode(image_data.split(',')[1])  # Eliminar la cabecera del base64
            image = Image.open(BytesIO(image_data))
            decoded_objects = decode(image)
            result_code = ""


            if decoded_objects:
                result = decoded_objects[0].data.decode('utf-8')
                if not decoded_objects:
                    result_code = "Lectura no valida"
                    return render(request, 'productos/barcode.html', {'code':  result_code})

                for resultado in decoded_objects:
                    result_code = resultado.data.decode("utf-8")
                    result_type = resultado.type

                    if result_type == 'EAN13':  # Filtrar por tipo de código de barras
                        print("Código:", result_code)
                        print("Tipo:", result_type)
                    elif result_type == 'QRCODE':
                        print("Código:", result_code)
                        print("Tipo:", result_type)
                    else:
                        result_code = "Lectura no valida"
                return JsonResponse({'success': True, 'barcode': result})
            else:
                return JsonResponse({'success': False, 'message': 'No se pudo leer el código de barras.'})
    return render(request, 'lector/camera_reader.html')

def bar_codes(request):
    # Asegúrate de tener una imagen de prueba con un código de barras o QR
    #imagen = Image.open(r"/Users/darksus/Documents/ProyectosPython/inventario/inventario/codigo_barras.png")
    return render(request, 'productos/barcode.html')

    imagen = Image.open(r"C:\Users\WPSIS07\Documents\Projects\inventario\inventario\codigo_qr.png")
    resultados = decode(imagen)
    result_code = ""

    if not resultados:
        result_code = "Lectura no valida"
        return render(request, 'productos/barcode.html', {'code':  result_code})

    for resultado in resultados:
        result_code = resultado.data.decode("utf-8")
        result_type = resultado.type

        if result_type == 'EAN13':  # Filtrar por tipo de código de barras
            print("Código:", result_code)
            print("Tipo:", result_type)
        elif result_type == 'QRCODE':
            print("Código:", result_code)
            print("Tipo:", result_type)
        else:
            result_code = "Lectura no valida"

            
    return render(request, 'productos/barcode.html', {'code':  result_code})


def listar_productos(request):
    productos = Producto.objects.all()
    return render(request, 'productos/listar.html', {'productos': productos})

def agregar_producto(request):
    if request.method == 'POST':
        form = ProductoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('listar_productos')
    else:
        form = ProductoForm()
    return render(request, 'productos/agregar.html', {'form': form})

def buscar_producto(request):
    if 'codigo_barras' in request.GET:
        codigo_barras = request.GET['codigo_barras']
        producto = get_object_or_404(Producto, codigo_barras=codigo_barras)
        return render(request, 'productos/detalle.html', {'producto': producto})
    return render(request, 'productos/buscar.html')

from django.urls import path
from . import views

urlpatterns = [
    path('', views.listar_productos, name='listar_productos'),
    path('barcode/', views.bar_codes, name='barcode'),
    path('api/capImgBarCode/', views.capImgBarCode, name='capImgBarCode'),
    path('agregar/', views.agregar_producto, name='agregar_producto'),
    path('buscar/', views.buscar_producto, name='buscar_producto'),
]

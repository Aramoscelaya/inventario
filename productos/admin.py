from django.contrib import admin

from . import models


class ProductoAdmin(admin.ModelAdmin):
    # Campos de solo lectura
    readonly_fields = ('created', 'updated')
    # Columnas a mostrar en la tabla
    list_display = ('nombre', 'codigo_barras', 'created')
    # Orden jerárquico de las columnas en la tabla. Usar '-' para invertir el orden.
    ordering = ('-updated',)
    # Campo para crear una jerarquía de fechas de filtro rápido (por mes y luego por día)
    date_hierarchy = 'created'
    # Campos de filtros
    list_filter = ('nombre', 'codigo_barras', 'created')


admin.site.register(models.Producto, ProductoAdmin)
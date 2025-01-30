from django.db import models

class Producto(models.Model):
    nombre = models.CharField(max_length=255)
    codigo_barras = models.CharField(max_length=100, unique=True)
    cantidad = models.IntegerField(default=0)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    created = models.DateTimeField(auto_now_add=True, verbose_name='Fecha de creación')
    updated = models.DateTimeField(auto_now=True, verbose_name='Fecha de modificación')

    class Meta:
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'
        ordering = ['-updated']
        permissions = [
            ('can_edit_product', 'Puede hacer todo en productos'),
        ]
    
    def __str__(self):
        return self.nombre


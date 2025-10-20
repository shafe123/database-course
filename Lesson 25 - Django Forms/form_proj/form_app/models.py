from django.db import models

# Create your models here.
class HoursWalked(models.Model):
    hours = models.FloatField()
    dateWalked = models.DateField(null=True)

    def __str__(self) -> str:
        return f"{self.dateWalked} - {self.hours}"
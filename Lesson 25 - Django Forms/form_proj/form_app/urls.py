from django.urls import path, include
from form_app import views

urlpatterns = [
    path('', views.index, name='index'),
    path('hours/', views.hours, name='hours'),
    path('delete/', views.delete, name='delete'),
]

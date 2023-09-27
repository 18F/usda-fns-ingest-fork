"""usda_fns_ingestor URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
"""
from django.urls import path, include
from django.contrib import admin
from data_ingest import urls

app_name = 'usda_fns_ingestor'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('data_ingest/', include(urls, namespace='data_ingest')),
    path('accounts/', include('django.contrib.auth.urls')),
]

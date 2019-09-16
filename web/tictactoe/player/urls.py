from django.urls import path

from .views import home

urlpatterns = [
  path(r'home', home, name="player_home"),
]

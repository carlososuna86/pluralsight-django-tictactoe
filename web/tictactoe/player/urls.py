from django.urls import path
from django.contrib.auth.views import LoginView, LogoutView

from .views import home

urlpatterns = [
  path(r'home', home, name="player_home"),
  path(r'login', 
    LoginView.as_view(template_name="player/login_form.html"),
    name="player_login"
  ),
  path(r'logout',
    LogoutView.as_view(),
    name="player_logout"
  )
]

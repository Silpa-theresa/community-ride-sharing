@echo off
echo Fixing Django URL configuration...

REM Create backend/urls.py with correct configuration
(
echo from django.contrib import admin
echo from django.urls import path, include
echo from api.views import home
echo.
echo urlpatterns = [
echo     path('admin/', admin.site.urls),
echo     path('api/', include('api.urls')),
echo     path('', home, name='home'),
echo ]
) > backend\urls.py

echo Backend URLs updated.

REM Create api/urls.py
(
echo from django.urls import path
echo from . import views
echo.
echo urlpatterns = [
echo     path('hello/', views.hello_world, name='hello_world'),
echo     path('', views.home, name='api_home'),
echo ]
) > api\urls.py

echo API URLs updated.

REM Create templates directory
mkdir templates\api 2>nul

REM Create a simple index.html file
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo     ^<title^>Community Ride Sharing^</title^>
echo ^</head^>
echo ^<body^>
echo     ^<h1^>?? Community Ride Sharing^</h1^>
echo     ^<p^>? Your website is working!^</p^>
echo     ^<p^>Visit: ^<a href="http://127.0.0.1:8000/"^>http://127.0.0.1:8000/^</a^>^</p^>
echo     ^<p^>^<a href="/api/hello/"^>Test API^</a^> | ^<a href="/admin/"^>Admin^</a^>^</p^>
echo ^</body^>
echo ^</html^>
) > templates\api\index.html

echo Frontend template created.

echo.
echo Starting Django server...
echo Open your browser to: http://127.0.0.1:8000/
echo.
python manage.py runserver

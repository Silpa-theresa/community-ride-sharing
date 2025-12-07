Write-Host "=== FIXING DJANGO SETUP ===" -ForegroundColor Cyan

# 1. Update api/views.py with home function
Write-Host "1. Updating api/views.py..." -ForegroundColor Yellow
@"
from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['GET'])
def hello_world(request):
    return Response({"message": "Hello from Django! Your API is connected!"})

def home(request):
    return render(request, 'api/index.html')
"@ | Out-File -FilePath "api\views.py" -Encoding UTF8

# 2. Create template directory and file
Write-Host "2. Creating template..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "templates\api"

@"
<!DOCTYPE html>
<html>
<head><title>Community Ride</title></head>
<body>
<h1>🚗 Community Ride Sharing</h1>
<p>✅ Your website is working!</p>
<p>Visit <a href='/api/hello/'>API Test</a></p>
</body>
</html>
"@ | Out-File -FilePath "templates\api\index.html" -Encoding UTF8

# 3. Verify backend/urls.py
Write-Host "3. Checking backend/urls.py..." -ForegroundColor Yellow
$backendContent = Get-Content backend\urls.py -Raw
if ($backendContent -notmatch "from api.views import home") {
    Write-Host "   Fixing import..." -ForegroundColor Yellow
    $backendContent = $backendContent -replace "from django.contrib import admin", "from django.contrib import admin`nfrom api.views import home"
    $backendContent | Out-File -FilePath "backend\urls.py" -Encoding UTF8
}

# 4. Start the server
Write-Host "`n=== STARTING SERVER ===" -ForegroundColor Green
Write-Host "Open your browser to: http://127.0.0.1:8000/" -ForegroundColor Green
Write-Host "Press CTRL+C to stop the server`n" -ForegroundColor Yellow

python manage.py runserver

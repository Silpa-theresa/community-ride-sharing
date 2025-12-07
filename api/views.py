from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['GET'])
def hello_world(request):
    return Response({"message": "Hello from Django! Your API is connected!"})

def home(request):
    return render(request, 'api/index.html')

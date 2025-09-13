from rest_framework.decorators import api_view
from rest_framework.response import Response

# This decorator defines which HTTP methods this view can handle.
@api_view(['GET'])
def hello_world(request):
    # This function will run when someone visits the API endpoint.
    return Response({"message": "Hello from Django! Your API is connected!"})
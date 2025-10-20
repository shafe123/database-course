# Create your views here.
from django.http import HttpResponse

def index(request):
    return HttpResponse("<h1>CS393 Rocks!</h1>")
# Create your views here.
from django.http import HttpResponse

from pprint import pprint


def output_request(request):
    response = HttpResponse(mimetype='text/plain')
    response.write("Post:\n")
    pprint(request.POST, response)
    response.write("Files:\n")
    pprint(request.FILES, response)
    return response



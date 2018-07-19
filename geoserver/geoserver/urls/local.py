

from django.conf.urls import  include, url

from django.contrib import admin
from geoserver import settings
# from settings.local import MEDIA_ROOT, STATIC_ROOT
from django.views.static import serve

import semantics.urls as semantic_urls
import labels.urls as labels_urls
# from questions.urls import urlpatterns
import questions.urls
import semantics.urls
import labels.urls

admin.autodiscover()



urlpatterns = [
    url(r'^semantics/', include('semantics.urls')),
    url(r'^labels/', include('labels.urls')),
    url(r'^questions/', include('questions.urls')),
    url(r'^admin/', admin.site.urls)
]

if settings.local.DEBUG:
    urlpatterns += [
        url(r'^media/(?P<path>.*)$', serve,{'document_root': settings.local.MEDIA_ROOT }),
        url(r'^static/(?P<path>.*)$', serve, {'document_root': settings.local.STATIC_ROOT }),
   ]

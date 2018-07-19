'''
Created on Jul 21, 2014

@author: minjoon
'''

from django.conf.urls import url

from questions import views

urlpatterns = [
    url(r'^upload/$', views.QuestionUploadView, name='questions-upload'),
    url(r'^upload/choice$', views.ChoiceUploadView, name='questions-upload-choice'),
    url(r'^list/(?P<query>[\w+]+)/$', views.QuestionListView.as_view(), name='questions-list'),
    url(r'^delete/(?P<slug>\d+)/$', views.QuestionDeleteView, name='questions-delete'),
    url(r'^download/(?P<query>[\w+]+)/$', views.QuestionDownloadView, name='questions-download'),
    url(r'^update/all/$', views.QuestionUpdateAllView, name='questions-update_all'),
    url(r'^update/(?P<slug>\d+)/$', views.QuestionUpdateView, name='questions-update'),
    url(r'^detail/(?P<slug>\d+)/$', views.QuestionDetailView, name='questions-detail'),
    url(r'^createtag/$', views.TagCreateView, name='questions-tagcreate'),
]
from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class SimpleSignUpForm(UserCreationForm):
    full_name = forms.CharField(max_length=100, required=True)
    dob = forms.DateField(required=True, widget=forms.DateInput(attrs={'type': 'date'}))
    phone_number = forms.CharField(max_length=15, required=True)
    email = forms.EmailField(required=True)
    address = forms.CharField(max_length=255, required=True)

    class Meta:
        model = User
        fields = ("username", "full_name", "email", "dob", "phone_number", "address", "password1", "password2")

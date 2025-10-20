from django import forms
from .models import HoursWalked

class Hours(forms.Form):
    hours_walked = forms.FloatField(label="Hours Walked", min_value=0, max_value=100)
    date_walked = forms.DateField(label="Date Served", widget=forms.widgets.DateInput(attrs={'type': 'date'}))

class HoursDelete(forms.Form):
    hours_date = forms.ModelChoiceField(HoursWalked.objects.all(), to_field_name='id', label='Hours date')
from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import HoursWalked


# Create your views here.
def index(request):
    return render(request, "form_app/index.html")


from form_app.forms import Hours, HoursDelete


def hours(request):
    if request.method == "POST":
        submitted_form = Hours(request.POST)
        if submitted_form.is_valid():
            newEntry = HoursWalked(
                hours=submitted_form.cleaned_data["hours_walked"],
                dateWalked=submitted_form.cleaned_data["date_walked"],
            )
            newEntry.save()

    form = Hours(initial={"hours_walked": 5})
    deleteForm = HoursDelete()
    all_hours = HoursWalked.objects.all()
    context = {"current_hours": all_hours, "form": form, "delete": deleteForm}
    return render(request, "form_app/hours.html", context)


def delete(request):
    if request.method == "POST":
        submitted_form = HoursDelete(request.POST)
        if submitted_form.is_valid():
            toDelete = HoursWalked.objects.get(pk=submitted_form['hours_date'].pk)
            toDelete.delete()

    form = Hours(initial={"hours_walked": 5})
    deleteForm = HoursDelete()
    all_hours = HoursWalked.objects.all()
    context = {"current_hours": all_hours, "form": form, "delete": deleteForm}
    return render(request, "form_app/hours.html", context)
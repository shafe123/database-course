# 1. Contents
- [1. Contents](#1-contents)
- [2. Getting Started](#2-getting-started)
- [3. Assigning Hours](#3-assigning-hours)
  - [3.1. Create the models](#31-create-the-models)
  - [3.2. Create the Cadet view](#32-create-the-cadet-view)
  - [3.3. Create the Cadet form](#33-create-the-cadet-form)
  - [3.4. Verify](#34-verify)
  - [3.5. Rinse and Repeat](#35-rinse-and-repeat)


# 2. Getting Started
1. Create a database called `forms` in your MySQL server.
2. Grant access on the forms database to the Django cadet.
3. Create a Django form project
4. Create a Django form app
5. Add the form app to the form project as an installed app.
6. Change the project database settings, use a database called `forms`
7. Add a path to the project's urls that includes the app's urls.py file
8. Add a urls.py file to the app. 
9. Create the index
   1. Add a path in the app's urls to the root that displays the index view, name it `index`.
   2. Create an index view in the app that renders the template
10. Run the default migrations
11. Verify your app works!

# 3. Assigning Hours
## 3.1. Create the models
1. Create two models based on the design diagram in class
2. Write the commands in the command prompt to have Django create the tables for you
3. Verify that the tables were created in the database using SQL.

## 3.2. Create the Cadet view
1. Create a Cadet view
   1. Add a path in the app's urls to the `/cadet/` path.  
   2. Create a template that displays each cadet in the database.  If there are no cadets, display a short message.
   3. Create a view that renders the template with the appropriate context.

## 3.3. Create the Cadet form
1. Create a file called forms.py.  A simple Form is given as *an example* below.
   ```python
   from django import forms
   from .models import HoursWalked

   class Hours(forms.Form):
      hours_walked = forms.FloatField(label="Hours Walked", min_value=0, max_value=100)
   ```
2. For the Cadet model, add a class called Cadet that inherits from `forms.Form`.
3. Create the name and company fields in the form.
4. Add the following template below that displays the form with an action to the `/cadet/` url. 

    ```html
    <form action="{% url 'cadet' %}" method="post">
        {% csrf_token %}
        {{ form }}
        <input type="submit" value="Submit">
    </form>
    ```

5. Update your Cadet view such that it handles the POST request appropriately.  It should add a new Cadet to the database whenever someone submits a valid form.
6. Your Cadet view should render the same template with the new Cadet present in the list.

## 3.4. Verify
1. Verify that your app works as anticipated, try creating a new Cadet.  
2. You should see the new Cadet show up when the page reloads.

## 3.5. Rinse and Repeat
1. Do the same as above for the other class.
   1. Use the `/assign/` path for your view.
   2. Think about how you might display the foreign key, start with something basic.
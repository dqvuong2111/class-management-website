import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ClassManagementWebsite.settings')
django.setup()

from core.models import Clazz

def set_default_images():
    classes = Clazz.objects.all()
    count = 0
    for clazz in classes:
        # We set the relative path from MEDIA_ROOT
        clazz.image = 'class_images/default_class.png'
        clazz.save()
        count += 1
    print(f"Successfully updated {count} classes to use the default image.")

if __name__ == "__main__":
    set_default_images()

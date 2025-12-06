import os
import django
import sys

# Add the project root to the python path
sys.path.append(os.getcwd())

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ClassManagementWebsite.settings')
django.setup()

from core.models import Student

print(f"Total Students: {Student.objects.count()}")
print("Actual Student IDs in DB:")
ids = [s.pk for s in Student.objects.all()]
print(ids)

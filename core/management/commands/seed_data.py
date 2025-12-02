from django.core.management.base import BaseCommand
from datetime import date
from core.models import Teacher, Student, Staff, ClassType, Clazz

class Command(BaseCommand):
    help = 'Seeds the database with sample data'

    def handle(self, *args, **kwargs):
        self.stdout.write('Seeding data...')
        self.seed_data()
        self.stdout.write(self.style.SUCCESS('Data seeded successfully!'))

    def seed_data(self):
        # Create Teachers
        teacher1, _ = Teacher.objects.get_or_create(email="alan.turing@example.com", defaults={'full_name': "Dr. Alan Turing", 'dob': "1912-06-23", 'phone_number': "123-456-7890", 'address': "Bletchley Park", 'qualification': "Ph.D. in Mathematics"})
        teacher2, _ = Teacher.objects.get_or_create(email="grace.hopper@example.com", defaults={'full_name': "Grace Hopper", 'dob': "1906-12-09", 'phone_number': "098-765-4321", 'address': "Arlington, VA", 'qualification': "Ph.D. in Mathematics"})

        # Create Students
        student1, _ = Student.objects.get_or_create(email="ada.lovelace@example.com", defaults={'full_name': "Ada Lovelace", 'dob': "1815-12-10", 'phone_number': "111-222-3333", 'address': "London, England"})
        student2, _ = Student.objects.get_or_create(email="charles.babbage@example.com", defaults={'full_name': "Charles Babbage", 'dob': "1791-12-26", 'phone_number': "444-555-6666", 'address': "London, England"})

        # Create Staff
        staff1, _ = Staff.objects.get_or_create(email="john.neumann@example.com", defaults={'full_name': "John von Neumann", 'dob': "1903-12-28", 'phone_number': "777-888-9999", 'address': "Princeton, NJ", 'position': "Administrator"})

        # Create Class Types
        math_type, _ = ClassType.objects.get_or_create(code="MATH", defaults={'description': "Mathematics Courses"})
        cs_type, _ = ClassType.objects.get_or_create(code="CS", defaults={'description': "Computer Science Courses"})

        # Create Classes
        Clazz.objects.get_or_create(class_name="Introduction to Python", defaults={'class_type': cs_type, 'teacher': teacher2, 'staff': staff1, 'start_date': date(2025, 9, 1), 'end_date': date(2025, 12, 20), 'price': "199.99", 'room': "Room 101"})
        Clazz.objects.get_or_create(class_name="Advanced Algorithms", defaults={'class_type': cs_type, 'teacher': teacher1, 'staff': staff1, 'start_date': date(2025, 9, 1), 'end_date': date(2025, 12, 20), 'price': "299.99", 'room': "Room 102"})
        Clazz.objects.get_or_create(class_name="Calculus I", defaults={'class_type': math_type, 'teacher': teacher1, 'staff': staff1, 'start_date': date(2025, 9, 1), 'end_date': date(2025, 12, 20), 'price': "249.99", 'room': "Room 201"})

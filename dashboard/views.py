from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from core.models import Clazz, Teacher, Student, Staff, Enrollment
from .forms import ClassForm, TeacherForm, StudentForm, StaffForm, EnrollmentForm
from django.db.models import Count, Q

def is_staff_user(user):
    return user.is_staff

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def admin_dashboard_view(request):
    query = request.GET.get('q')
    classes = Clazz.objects.annotate(
        enrolled_students=Count('enrollments')
    )

    if query:
        classes = classes.filter(
            Q(class_name__icontains=query) |
            Q(teacher__full_name__icontains=query)
        )

    # Calculate stats
    total_classes = Clazz.objects.count()
    total_students = Student.objects.count()
    total_teachers = Teacher.objects.count()

    context = {
        'classes': classes,
        'query': query,
        'total_classes': total_classes,
        'total_students': total_students,
        'total_teachers': total_teachers,
    }
    return render(request, 'dashboard/dashboard.html', context)

@login_required
def student_dashboard_view(request):
    try:
        student = request.user.student
    except Student.DoesNotExist:
        messages.error(request, "You are not registered as a student.")
        return redirect('home')
        
    enrollments = student.enrollments.all()
    return render(request, 'dashboard/student_dashboard.html', {
        'student': student,
        'enrollments': enrollments
    })

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def add_class_view(request):
    if request.method == 'POST':
        form = ClassForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, "Class added successfully!")
            return redirect('dashboard:dashboard')
    else:
        form = ClassForm()
    return render(request, 'dashboard/add_class.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def edit_class_view(request, pk):
    clazz = get_object_or_404(Clazz, pk=pk)
    if request.method == 'POST':
        form = ClassForm(request.POST, request.FILES, instance=clazz)
        if form.is_valid():
            form.save()
            messages.success(request, "Class updated successfully!")
            return redirect('dashboard:dashboard')
    else:
        form = ClassForm(instance=clazz)
    return render(request, 'dashboard/edit_class.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def delete_class_view(request, pk):
    clazz = get_object_or_404(Clazz, pk=pk)
    clazz.delete()
    messages.success(request, "Class deleted successfully!")
    return redirect('dashboard:dashboard')

# Student Management
@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def manage_students_view(request):
    query = request.GET.get('q')
    students = Student.objects.all()

    if query:
        students = students.filter(
            Q(full_name__icontains=query) |
            Q(email__icontains=query)
        )

    return render(request, 'dashboard/manage_students.html', {'students': students, 'query': query})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def add_student_view(request):
    if request.method == 'POST':
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Student added successfully!")
            return redirect('dashboard:manage_students')
    else:
        form = StudentForm()
    return render(request, 'dashboard/add_student.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def edit_student_view(request, pk):
    student = get_object_or_404(Student, pk=pk)
    if request.method == 'POST':
        form = StudentForm(request.POST, instance=student)
        if form.is_valid():
            form.save()
            messages.success(request, "Student updated successfully!")
            return redirect('dashboard:manage_students')
    else:
        form = StudentForm(instance=student)
    return render(request, 'dashboard/edit_student.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def delete_student_view(request, pk):
    student = get_object_or_404(Student, pk=pk)
    student.delete()
    messages.success(request, "Student deleted successfully!")
    return redirect('dashboard:manage_students')

# Teacher Management
@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def manage_teachers_view(request):
    query = request.GET.get('q')
    teachers = Teacher.objects.all()

    if query:
        teachers = teachers.filter(
            Q(full_name__icontains=query) |
            Q(email__icontains=query)
        )

    return render(request, 'dashboard/manage_teachers.html', {'teachers': teachers, 'query': query})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def add_teacher_view(request):
    if request.method == 'POST':
        form = TeacherForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Teacher added successfully!")
            return redirect('dashboard:manage_teachers')
    else:
        form = TeacherForm()
    return render(request, 'dashboard/add_teacher.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def edit_teacher_view(request, pk):
    teacher = get_object_or_404(Teacher, pk=pk)
    if request.method == 'POST':
        form = TeacherForm(request.POST, instance=teacher)
        if form.is_valid():
            form.save()
            messages.success(request, "Teacher updated successfully!")
            return redirect('dashboard:manage_teachers')
    else:
        form = TeacherForm(instance=teacher)
    return render(request, 'dashboard/edit_teacher.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def delete_teacher_view(request, pk):
    teacher = get_object_or_404(Teacher, pk=pk)
    teacher.delete()
    messages.success(request, "Teacher deleted successfully!")
    return redirect('dashboard:manage_teachers')

# Enrollment Management
@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def manage_enrollments_view(request):
    query = request.GET.get('q')
    enrollments = Enrollment.objects.all()

    if query:
        enrollments = enrollments.filter(
            Q(student__full_name__icontains=query) |
            Q(clazz__class_name__icontains=query)
        )

    return render(request, 'dashboard/manage_enrollments.html', {'enrollments': enrollments, 'query': query})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def add_enrollment_view(request):
    if request.method == 'POST':
        form = EnrollmentForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Student enrolled successfully!")
            return redirect('dashboard:manage_enrollments')
    else:
        form = EnrollmentForm()
    return render(request, 'dashboard/add_enrollment.html', {'form': form})

@login_required
@user_passes_test(is_staff_user, login_url="accounts:login")
def delete_enrollment_view(request, pk):
    enrollment = get_object_or_404(Enrollment, pk=pk)
    enrollment.delete()
    messages.success(request, "Enrollment removed successfully!")
    return redirect('dashboard:manage_enrollments')
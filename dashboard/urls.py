from django.urls import path
from . import views

app_name = 'dashboard'

urlpatterns = [
    path('admin_dashboard/', views.admin_dashboard_view, name='admin_dashboard'),
    path('', views.admin_dashboard_view, name='dashboard'),
    path('student/', views.student_dashboard_view, name='student_dashboard'),
    
    # Class Management
    path('add_class/', views.add_class_view, name='add_class'),
    path('edit_class/<int:pk>/', views.edit_class_view, name='edit_class'),
    path('delete_class/<int:pk>/', views.delete_class_view, name='delete_class'),

    # Student Management
    path('students/', views.manage_students_view, name='manage_students'),
    path('students/add/', views.add_student_view, name='add_student'),
    path('students/edit/<int:pk>/', views.edit_student_view, name='edit_student'),
    path('students/delete/<int:pk>/', views.delete_student_view, name='delete_student'),

    # Teacher Management
    path('teachers/', views.manage_teachers_view, name='manage_teachers'),
    path('teachers/add/', views.add_teacher_view, name='add_teacher'),
    path('teachers/edit/<int:pk>/', views.edit_teacher_view, name='edit_teacher'),
    path('teachers/delete/<int:pk>/', views.delete_teacher_view, name='delete_teacher'),

    # Enrollment Management
    path('enrollments/', views.manage_enrollments_view, name='manage_enrollments'),
    path('enrollments/add/', views.add_enrollment_view, name='add_enrollment'),
    path('enrollments/delete/<int:pk>/', views.delete_enrollment_view, name='delete_enrollment'),
]
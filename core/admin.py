from django.contrib import admin
from .models import (
    Teacher,
    Student,
    Staff,
    ClassType,
    Clazz,
    Enrollment,
    Schedule,
    Attendance,
    Feedback
)

class EnrollmentAdmin(admin.ModelAdmin):
    list_display = ('enrollment_id', 'get_student_name_vietnamese', 'get_class_name', 'enrollment_date')
    
    def get_student_name_vietnamese(self, obj):
        return obj.student.full_name
    get_student_name_vietnamese.short_description = 'Tên Học Sinh'
    
    def get_class_name(self, obj):
        return obj.clazz.class_name
    get_class_name.short_description = 'Class Name'

# Đăng ký từng model để chúng xuất hiện trên trang admin
admin.site.register(Teacher)
admin.site.register(Student)
admin.site.register(Staff)
admin.site.register(ClassType)
admin.site.register(Clazz)
admin.site.register(Enrollment, EnrollmentAdmin)
admin.site.register(Schedule)
admin.site.register(Attendance)
admin.site.register(Feedback)
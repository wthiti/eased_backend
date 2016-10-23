# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EasedBackend.Repo.insert!(%EasedBackend.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start

EasedBackend.Repo.delete_all(EasedBackend.TeacherStudentMatch)
EasedBackend.Repo.delete_all(EasedBackend.Student)
EasedBackend.Repo.delete_all(EasedBackend.Teacher)
EasedBackend.Repo.delete_all(EasedBackend.RequestTeacher)
EasedBackend.Repo.delete_all(EasedBackend.Request)

student = %EasedBackend.Student{
  name: Faker.Name.name,
  phone: Faker.Phone.EnUs.phone,
  email: Faker.Internet.safe_email,
  facebook_url: Faker.Avatar.image_url(200, 200)
}

student = EasedBackend.Repo.insert!(student)

teacher = %EasedBackend.Teacher{
  name: Faker.Name.name,
  phone: Faker.Phone.EnUs.phone,
  email: Faker.Internet.safe_email,
  facebook_url: Faker.Avatar.image_url(200, 200)
}

teacher = EasedBackend.Repo.insert!(teacher)

teacher_student_match = %EasedBackend.TeacherStudentMatch{
  student_id: student.id,
  teacher_id: teacher.id,
  possibility: :rand.uniform(100)
}

EasedBackend.Repo.insert!(teacher_student_match)

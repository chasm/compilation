User.destroy_all

user = User.create({
  name_first: "Chas.",
  name_last: "Munat",
  email: "chas@munat.com",
  password: "12345",
  password_confirmation: "12345"
})
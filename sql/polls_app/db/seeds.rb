# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({username: 'Barrett'})
User.create({username: 'Kat'})

Poll.create({author_id: 1, title: "What's the best language?"})

Question.create({poll_id: 1, text: "What's the best high level language?"})
Question.create({poll_id: 1, text: "What's the best low level language?"})

AnswerChoice.create({question_id: 1, text: "Python"})
AnswerChoice.create({question_id: 1, text: "Ruby"})
AnswerChoice.create({question_id: 1, text: "Other?"})

AnswerChoice.create({question_id: 2, text: "C++"})
AnswerChoice.create({question_id: 2, text: "Rust"})
AnswerChoice.create({question_id: 2, text: "Other?"})

Response.create({user_id: 2, answer_choice_id: 3})
Response.create({user_id: 2, answer_choice_id: 6})
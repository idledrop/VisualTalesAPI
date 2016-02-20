# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

story = Story.create({title: 'The puppet master', author: 'Jon', email: 'jon@jon.com', description: 'hello world test'})

jigsaw = Character.create({name: 'Jigsaw', description: 'creepy bike guy', portrait: 'file/path', story: story})
sitter = Character.create({name: "Unsuspecting babysitter", description: "Just walking by", portrait: "file/path", story: story})

jigsaw_angry = Pose.create({name:'Angry', image:'/path', character: jigsaw})
jigsaw_violent = Pose.create({name:'Violent', image:'/path', character: jigsaw})

sitter_afraid = Pose.create({name:'Afraid', image:'/path', character: sitter})
sitter_dying = Pose.create({name:'Dying', image:'/path', character: sitter})

story.tags.create({name: 'horror'})
story.tags.create({name: 'B-Film'})

house = story.scenes.create({name:'Abandonded Home', description:'Creepy empty house with no electric', background: 'image/path', order: 1})
backyard = story.scenes.create({name:'Back of house', description:'Creepy empty house with no electric', background: 'image/path', order: 2})

house.events.create(pose:sitter_afraid, position_x: 20, position_y: 20, script: 'What is this place?  This cant be little timmys home', order:1)
house.events.create(pose:sitter_afraid, position_x: 20, position_y: 20, script: 'Hears screaming from the back yard', order:2)

backyard.events.create(pose:jigsaw_angry, position_x: 20, position_y: 20, script: 'You are next!', order: 1)
backyard.events.create(pose:sitter_afraid, position_x: 20, position_y: 20, script: 'Ahhh! (runs away)', order: 2)
backyard.events.create(pose:jigsaw_violent, position_x: 20, position_y: 20, script: 'How do you like my knife!', order: 3)
backyard.events.create(pose:sitter_dying, position_x: 20, position_y: 20, script: '(blood gurgles)', order: 4)
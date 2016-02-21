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



story = Story.create({title: 'The story of a girl', author: 'Jon', email: 'josh@jon.com', description: 'cried a river and drown the whole world.'})

girl = Character.create({name: 'The Girl', description: 'a sad girl', portrait: 'file/path', story: story})
guy = Character.create({name: "The Guy", description: "a nice guy", portrait: "file/path", story: story})

girl_crying = Pose.create({name:'Crying', image:'/path', character: girl})
girl_happy = Pose.create({name:'Happy', image:'/path', character: girl})

guy_scared = Pose.create({name:'Scared', image:'/path', character: guy})
guy_happy = Pose.create({name:'happy', image:'/path', character: guy})

story.tags.create({name: 'drama'})
story.tags.create({name: 'love'})
story.tags.create({name: 'music video'})

house = story.scenes.create({name:'House', description:'studio apartment', background: 'image/path', order: 1})
bar = story.scenes.create({name:'A bar', description:'dark bar', background: 'image/path', order: 2})

house.events.create(pose:girl_crying, position_x: 20, position_y: 20, script: 'is living there', order:1)
house.events.create(pose:girl_crying, position_x: 20, position_y: 20, script: '(singing) this is the story...', order:2)
house.events.create(pose:guy_scared, position_x: 20, position_y: 20, script: '(looks at photograph)', order:2)

bar.events.create(pose:girl_happy, position_x: 20, position_y: 20, script: 'I love drunk', order: 1)
bar.events.create(pose:guy_happy, position_x: 20, position_y: 20, script: 'Ahhh! I absolutely love her.', order: 2)

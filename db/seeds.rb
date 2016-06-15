# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#university_list = [
#    ['harvard.edu', 'www.directory.harvard.edu'],
#    ['upenn.edu', 'directory.apps.upenn.edu/directory/jsp/fast.do'],
#    ['yale.edu' , 'directory.yale.edu'],
#    ['dartmouth.edu' , 'http://dartmouth.edu/directory'],
#    ['cornell.edu' , 'www.cornell.edu/search/?tab=people'],
#    ['mit.edu' , 'web.mit.edu/people.html'],
#    ['princeton.edu' , 'search.princeton.edu/'],
#    ['columbia.edu' , 'directory.columbia.edu/people/'],
#    ['brown.edu' , 'directory.brown.edu/'],
#    ['illinois.edu', 'illinois.edu/ds/search'],
#    ['umich.edu', 'mcommunity.umich.edu'],
#    ['unc.edu', 'itsapps.unc.edu/dir/dirSearch/view.htm'],
#    ['wustl.edu', 'wustl.edu/directory/'],
#    ['bu.edu', 'http://www.bu.edu/directory/'],
#    ['virginia.edu', 'http://jm.acs.virginia.edu/commserv/phonebook/']
#]

university_list = [
    ['upenn.edu', 'directory.apps.upenn.edu/directory/jsp/fast.do'],
    ['illinois.edu', 'illinois.edu/ds/search'],
    ['umich.edu', 'mcommunity.umich.edu'],
    ['unc.edu', 'itsapps.unc.edu/dir/dirSearch/view.htm'],
    ['wustl.edu', 'wustl.edu/directory/'],
    ['bu.edu', 'http://www.bu.edu/directory/'],
    ['virginia.edu', 'http://jm.acs.virginia.edu/commserv/phonebook/'],
    ['columbia.edu' , 'directory.columbia.edu/people/']
]

university_list.each do |name, directory|
  University.create(name:name, directory:directory)
end

User.create!(first_name:  "Example",
             last_name: "User",
             email: "example@upenn.edu",
             password:              "foobarA9",
             password_confirmation: "foobarA9",
             activated: true,
             activated_at: Time.zone.now)

#99.times do |n|
#  first  = Faker::Name.name
#  last   = Faker::Name.name
#  email = "example-#{n+1}@upenn.edu"
#  password = "passwordA9"
#  User.create!(first_name:  first,
#               last_name: last,
#               email: email,
#               password:              password,
#               password_confirmation: password,
#               activated: true,
#               activated_at: Time.zone.now)
#end


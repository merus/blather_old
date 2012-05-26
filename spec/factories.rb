Factory.define :user do |user|
	user.name		"Matt Cramp"
	user.email		"merus@merus.com.au"
	user.password		"foobar"
	user.password_confirmation	"foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "just setting up my blthr"
  micropost.association :user
end

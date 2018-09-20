if State.all.empty?
  UnitedStates.all.each do |state|
    State.create(name: state.name, code: state.postal_code)
  end
end
# dummy info for playing with site
# User.create(username: "foo!!", email: "foobarbaz@foo.com", password: "foothings")
# User.create(username: "bar!!", email: "foobarbaz@bar.com", password: "barthings")
# User.create(username: "baz!!", email: "foobarbaz@baz.com", password: "bazthings")
# Trail.create(name: "mt shasta", length: "5.4", difficulty: "6", start_alt: "1450", end_alt: "5000", state: State.find_by(code: "CA"), creator_id: "1")
# Trail.create(name: "mt st helens", length: "7", difficulty: "7", start_alt: "1600", end_alt: "4000", state: State.find_by(code: "WA"), creator_id: "2")
# Trail.create(name: "mt hood", length: "10.7", difficulty: "9", start_alt: "3000", end_alt: "7683", state: State.find_by(code: "OR"), creator_id: "3")
# UserTrail.create(user_id: "1", trail_id: "1")
# UserTrail.create(user_id: "1", trail_id: "2")
# UserTrail.create(user_id: "1", trail_id: "3")
# UserTrail.create(user_id: "2", trail_id: "2")
# UserTrail.create(user_id: "2", trail_id: "3")
# UserTrail.create(user_id: "3", trail_id: "3")

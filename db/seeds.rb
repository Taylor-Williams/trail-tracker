if State.all.empty?
    UnitedStates.all.each do |state|
    State.create(name: state.name, code: state.postal_code)
  end
end

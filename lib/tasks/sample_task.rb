namespace :users do
  namespace :pool do
    def loop
      User.each do |u|
        u.name = u.name.to_upper()
        u.save!
      end
    end
  end
end
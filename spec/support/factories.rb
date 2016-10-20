FactoryGirl.define do
  # factories for each model go here
  factory :user, aliases: [:requester, :professional] do
    first_name 'Chad'
    last_name 'Clancey'
    email 'cclancey007@test.com'
    phone '555-555-1234'
    street_address '123 Test St.'
    city 'Denver'
    state 'CO'
    zipcode '80202'
    password '12345'
    password_confirmation '12345'

    factory :requester_user do
      role "requester"
    end

    factory :professional_user do
      role "professional"
    end
  end
end

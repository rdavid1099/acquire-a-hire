FactoryGirl.define do
  # factories for each model go here
  factory :user, aliases: [:requester, :professional] do
    first_name 'Chad'
    last_name 'Clancey'
    email 'cclancey007@test.com'
    phone '555-555-1234'
    street_address '123 Test St.'
    city 'Denver'
    state 'Colorado'
    zipcode '80202'
    password '12345'
    password_confirmation '12345'

    factory :requester_user do
      after(:create) do |user|
        user.roles << Role.new(name: "requester")
      end
    end

    factory :professional_user do
      after(:create) do |user|
        user.roles << Role.new(name: "professional")
      end
    end
  end

  sequence :job_title do |n|
    "Job #{n}"
  end

  factory :skill do
    name "Espionage"
  end

  factory :job do
    title { generate(:job_title) }
    skill
    min_price 100
    max_price 1000
    requester
    # professional
    status "pending"
    description "do the thing"
  end
end

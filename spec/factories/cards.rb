FactoryGirl.define do
  
  factory :card do
    original   "star"
    translated "звезда"
    review     DateTime.now
    deck
    user
    true_answers 0
    try          0
  end
end
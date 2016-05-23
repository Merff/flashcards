FactoryGirl.define do
  
  factory :card do
    original   "star"
    translated "звезда"
    review     DateTime.now
    deck
    user
    repeat   1
    efactor  2.5 
    interval 0
  end
end
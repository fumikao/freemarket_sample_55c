FactoryBot.define do
  factory :user do
    id              {1}
    email           {"test@test.com"}
    password        {"password"}
    nickname        {"test"}
    firstname       {"test"}
    lastname        {"test"}
    firstname_kana  {"test"}
    lastname_kana   {"test"}
    birthday        {"1990-01-01"}
    tel             {"09011111111"}
    customer        {"aaaaaaaaaaa"}
    card            {"aaaaaaaaaaa"}
  end
end
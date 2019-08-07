FactoryBot.define do
  factory :user do
    id              {1}
    email           {"test@test.com"}
    password        {"password"}
    nickname        {"test"}
    firstname       {"ああああ"}
    lastname        {"いいいい"}
    firstname_kana  {"アアアア"}
    lastname_kana   {"イイイイ"}
    birthday        {"1990-01-01"}
    tel             {"09011111111"}
    customer        {"aaaaaaaaaaa"}
    card            {"aaaaaaaaaaa"}
  end
end
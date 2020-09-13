# create table posts
Sequel.migration do
  change do
    create_table :posts do |_t|
      primary_key :id
      String   :title,        null: false
      String   :article,      null: false
      String   :author_login, null: false
      String   :author_ip,    null: false
    end
  end
end

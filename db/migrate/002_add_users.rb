# create table users
Sequel.migration do
  change do
    create_table :users do |_t|
      column :login, String, primary_key: true
    end
  end
end

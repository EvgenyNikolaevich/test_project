# create table rates
Sequel.migration do
  change do
    create_table :rates do |_t|
      Float   :rate,    default: 0
      Integer :count,   default: 1
      Integer :post_id, null: false
    end
  end
end

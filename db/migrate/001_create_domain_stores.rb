class CreateDomainStores < ActiveRecord::Migration
  def change
    create_table :domain_stores do |t|
      t.string :domain
    end
  end
end

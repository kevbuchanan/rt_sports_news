class CreateCommentvotes < ActiveRecord::Migration
  def change
    create_table :commentvotes do |t|
      t.references :comment
      t.references :user
      t.timestamps
    end
  end
end

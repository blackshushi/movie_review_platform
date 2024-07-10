class Init < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.belongs_to :director, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.integer :year, null: false
      t.timestamps

      t.references :reviews, foreign_key: true
      t.index :title
    end

    create_table :directors do |t|
      t.string :name, null: false
      t.timestamps

      t.references :movies, foreign_key: true
    end

    create_table :actors do |t|
      t.string :name, null: false
      t.references :movies, foreign_key: true
      t.timestamps
    end

    create_table :film_locations do |t|
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :actor, foreign_key: true

      t.string :location, null: false
      t.string :country, null: false
      t.timestamps
    end

    create_table :reviews do |t|
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.float :rating, null: false
      t.text :comment, null: false
      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.timestamps

      t.references :reviews, foreign_key: true
    end
  end
end

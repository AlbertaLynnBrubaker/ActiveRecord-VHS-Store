 create_table :clients do |t|
      t.string :name
      t.string :home_address
    end

    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.integer :length
      t.string :director
      t.string :description
      t.boolean :female_director
    end

    create_table :vhs do |t|
      t.string :serial_number
      t.integer :movie_id
    end

    create_table :rentals do |t|
      t.boolean :current
      t.integer :client_id
      t.integer :vhs_id
    end

    create_table :genres do |t|
      t.string :name
    end

    create_table :movie_genres do |t|
      t.integer :movie_id
      t.integer :genre_id
    end
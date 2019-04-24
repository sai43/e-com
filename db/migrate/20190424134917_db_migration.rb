class DbMigration < ActiveRecord::Migration[5.2]
  def change

    create_table "friendly_id_slugs" do |t|
      t.string     "slug"
      t.integer  "sluggable_id",   limit: 8
      t.integer  "sequence",       limit: 8, default: 1, null: false
      t.string     "sluggable_type"
      t.string     "scope"
      t.datetime "created_at"
    end

    add_index "friendly_id_slugs", ["slug", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true, using: :btree
    add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree

    create_table "roles" do |t|
      t.string :name
      t.references :resource, :polymorphic => true
      t.timestamps
    end

    add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    # add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ], name: "index_users_roles_on_user_id_and_role_id", using: :btree)

    create_table "sessions" do |t|
      t.string     "session_id", null: false
      t.text     "data"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
    add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

    create_table "users" do |t|
      t.string     "email",                               default: "",    null: false
      t.string     "encrypted_password",                  default: "",    null: false
      t.string     "password_salt",                       default: "",    null: false
      t.string     "reset_password_token"
      t.string     "remember_token"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",             limit: 8, default: 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string     "current_sign_in_ip"
      t.string     "last_sign_in_ip"
      t.string     "first_name"
      t.string     "last_name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string     "last_preview_cell_number"
      t.string     "last_preview_cell_carrier"
      t.datetime "reset_password_sent_at"
      t.boolean  "is_email_verified"
      t.string     "user_guid"
      t.boolean  "enable_analytics_email",              default: true
      t.string     "authentication_token"
      t.boolean  "active",                              default: true
      t.string     "invitation_token"
      t.datetime "invitation_created_at"
      t.datetime "invitation_sent_at"
      t.datetime "invitation_accepted_at"
      t.integer  "invitation_limit",          limit: 8
      t.integer  "invited_by_id",             limit: 8
      t.string     "invited_by_type"
      t.integer  "invitations_count",         limit: 8, default: 0
      t.string     "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.boolean  "super_user",                default: false, null: false
      t.string   :user_type, default: User.types.advanced
    end

    add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree


    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :products do |t|
      t.string :title
      t.float :price, default: '0.0'
      t.string :description
      t.json :products, :product_images
      t.timestamps
    end

    create_table :orders do |t|
      t.string :status , default: 'Created'
      t.string :description
      t.string :pay_method, default: '$'
      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      t.references :order, foreign_key: true
      t.timestamps
    end

  end

  def down
    raise "no going back from this"
  end

end

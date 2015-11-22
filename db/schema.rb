ActiveRecord::Schema.define(version: 20151122032156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "archive",    default: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.boolean  "status",      default: false
    t.string   "description"
    t.date     "due_date"
    t.integer  "list_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end

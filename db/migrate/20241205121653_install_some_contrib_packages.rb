class InstallSomeContribPackages < ActiveRecord::Migration[7.1]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    execute "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;"
  end

  def down
    execute "DROP EXTENSION IF EXISTS pg_trgm;"
    execute "DROP EXTENSION IF EXISTS fuzzystrmatch;"
  end
end

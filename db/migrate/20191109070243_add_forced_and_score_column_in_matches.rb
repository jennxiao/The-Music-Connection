class AddForcedAndScoreColumnInMatches < ActiveRecord::Migration
  def change
    add_column :matches, :forced, :boolean
    add_column :matches, :score, :integer
  end
end

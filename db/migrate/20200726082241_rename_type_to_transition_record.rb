class RenameTypeToTransitionRecord < ActiveRecord::Migration[5.1]
  def change
    rename_column :transition_records, :type, :transition_type
  end
end

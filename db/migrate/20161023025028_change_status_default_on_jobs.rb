class ChangeStatusDefaultOnJobs < ActiveRecord::Migration[5.0]
  def change
    change_column_default :jobs, :status, "available"
  end
end

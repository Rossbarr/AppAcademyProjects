# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
  SELECT DISTINCT
    yr
  FROM
    nobels
  WHERE
    yr IN (
      SELECT DISTINCT
        yr
      FROM
        nobels
      WHERE
        subject = 'Chemistry' AND
        winner IS NULL
    ) AND yr IN (
      SELECT DISTINCT
        yr
      FROM
        nobels
      WHERE
        subject = 'Physics' AND
        winner IS NOT NULL
    )
  SQL
end

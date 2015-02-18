module Displayable

  def display_columns
    column_names
  end

  def temp_display_columns
    column_names
  end

  def display_column_index
    h = Hash[column_names.map.with_index.to_a]
  end

end

module TabularModelHelper

  def model_tabular_content(dataset, row_action=nil)
    unless dataset.blank?
      m = table_model(dataset)
      html = "<table class='table table-striped'><body>"
      html += model_table_headers(m, row_action)
      html += table_data(dataset).map { |r| model_table_row(m, r, row_action) }.join(' ')
      html += "</body></table>"
      html.html_safe
    end
  end

  def table_model(dataset)
    case 
      when dataset.class.name == 'ActiveRecord::Relation' 
      dataset.model
      when dataset.class.name[/Decorator/]
      dataset.object_class
      else
      dataset.class
    end
  end

  def table_data(dataset)
    case
      when dataset.class.name == 'ActiveRecord::Relation'
      dataset
      when dataset.class.name[/Decorator/]
      dataset
      else
      dataset.class.all
    end
  end

  def model_table_headers(a_model, row_action=nil)
    headers = a_model.display_columns.map {|c| "<th>#{c.humanize}</th>"}
    headers << '<th></th>' if row_action.present?
    "<tr>#{headers.join(' ')}</tr>"
  end

  def model_table_row(model, instance, row_action=nil)
    content = []
    model.display_columns.each_with_index { |c, i| content << "<td>#{model_table_cell(model, instance, c, i)}</td>"}
    "<tr>" + (content + action_cell(row_action, instance)).join(' ') + "</tr>"
  end

  def model_table_cell(model, instance, attr, index)
    refs = model.reflect_on_all_associations(:belongs_to).map(&:name)
    refs_ids = refs.map{ |r| "#{r.to_s}_id" }
    case
    when refs_ids.include?(attr)
      instance.send("#{attr.gsub(/_id$/,'')}".to_sym).name
    when model.columns[model.display_column_index[attr]].send(:type) == 'datetime'
      I18n.l(instance.send(attr.to_sym))
    else
      instance.send(attr.to_sym)
    end
  end

  def action_cell(row_action, instance)
    unless row_action.blank?
      a = row_action
      a = [row_action] if row_action.class.to_s != 'Array'
      ['<td>' +
       a.map do
         |r|
         if r[:type] == 'button'
           if r[:nested_par].present?
             button_to("#{r[:name]}", send("#{r[:path]}".to_sym, r[:nested_par], instance), method: r[:method]) 
           else
             button_to("#{r[:name]}", send("#{r[:path]}".to_sym, instance), method: r[:method]) 
           end
         else
           if r[:nested_par].present?
             r.blank? ? ' ' : link_to("#{r[:name]}", send("#{r[:path]}".to_sym, r[:nested_par], instance))
           else
             r.blank? ? ' ' : link_to("#{r[:name]}", send("#{r[:path]}".to_sym, instance))
           end
         end
       end.join('') + '</td>' ]
    else
      []
    end
  end

end

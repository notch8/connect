module ApplicationHelper

  def amount_list(additional_amount = 5)
    ([[number_to_currency(5, :precision => 0), 5]] +
    (1..50).collect { |i| ["#{number_to_currency(25*i, :precision => 0)}", 25*i]} +
    [[number_to_currency(additional_amount, :precision => 0), additional_amount]]).uniq
  end

  def bootstrap_class_for flash_type
    case flash_type.to_s
    when 'success'
      "alert-success"
    when 'error'
      "alert-danger"
    when 'alert'
      "alert-danger"
    when 'notice'
      "alert-info"
    else
      flash_type.to_s
    end
  end
end

module CardsHelper
  def formated_date(date)
    date.nil? ? '' : date.strftime('%d/%m/%Y')
  end
end

module ApplicationHelper

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :no_intraemphasis => true, :lax_html_blocks => true).render(text).html_safe
  end
  
  def show_avail_dates(from, to)
    unless from.nil? && to.nil?
      return "#{from.to_date.strftime('%d %B')} to #{to.to_date.strftime('%d %B')}"
    end
  end
  
  def month_option
    months = []
    1.upto(31) {|i| months << [i , i]}
    return months
  end
  
  def year_option
    years = []
    Time.now.year.upto(6.years.from_now.year) {|i| years << [i, i]}
    return years
  end
  
  def pay_now_options(price, paid)
    puts "price #{price} paid #{paid}"

    amountleft = price - paid

    opts = []
    if !amountleft.blank?
      1.upto(10) do |i|
        percent = i * 10
        percentage_amount = (amountleft * percent) / 100
        if i == 10
          opts << ["#{percent}% - full payment EUR #{percentage_amount}", percentage_amount]
        else
          opts << ["#{percent}% - payment EUR #{percentage_amount}", percentage_amount]
        end
      end
    end
    
    return opts.reverse
  end
  
  def people_amount 
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  end
end

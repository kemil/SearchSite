class BoatAvailPrice < ActiveRecord::Base
	belongs_to :boat

	validates_presence_of :period_start, :period_end, :period_price, :period_nights
  validates :period_end, :uniqueness => { :scope => [:boat_id, :period_start], :message => 'period must be unique per boat' }

  ###
  # Find available prices within the given period
  #
  # @param [Date] pickup_date
  # @param [Date] return_date
  ###
  def self.find_period(pickup_date, return_date)
    days = (return_date - pickup_date).to_i

    q = BoatAvailPrice.select("boat_id, sum(period_price) AS total_price, sum(period_nights) AS total_nights, min(period_start) AS RentStart, max(period_end) AS RentEnd")
    q = q.where("period_start >= ? AND period_start <= ? AND period_end >= ? AND period_end <= ?",
                pickup_date.to_s, return_date.prev_day.to_s, pickup_date.next_day.to_s, return_date.to_s)
    q = q.group("boat_id")
    q = q.having("sum(period_nights) = ? AND min(period_start)  = ? AND max(period_end) = ?", days, pickup_date.to_s, return_date.to_s)

    return q
  end
end

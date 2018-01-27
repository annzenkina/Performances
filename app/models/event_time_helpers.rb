module EventTimeHelpers
  def in_the_morning?
    parsed_time < 12
  end

  def in_the_evening?
    parsed_time >= 18
  end

  def in_the_afternoon?
    (parsed_time > 12 && parsed_time < 18)
  end

  def this_month?
    parsed_date <= Time.current.end_of_month
  end

  def this_week?
    parsed_date <= Chronic.parse('Sunday').to_date
  end

  def today?
    parsed_date == Date.current
  end

  def next_month?
    parsed_date <= Time.current.end_of_month + 1.month && parsed_date >=Time.current.end_of_month + 1.day
  end
end

module ApplicationHelper
  def format_datetime(datetime)
    datetime.strftime("%Y年%m月%d日 %H:%M")
  end

  def simple_datetime(datetime)
    datetime.strftime("%Y/%m/%d %H:%M")
  end
end
  
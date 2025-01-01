# frozen_string_literal: true

module ApplicationHelper
  def format_datetime(datetime)
    datetime.strftime('%Y年%m月%d日 %H:%M')
  end

  def simple_datetime(datetime)
    datetime.strftime('%Y/%m/%d %H:%M')
  end

  def nav_item(path, icon_class, label, method: :get)
    content_tag :li, class: 'nav__item' do
      link_to(path, method: method) do
        concat(content_tag(:i, '', class: "fa #{icon_class} icon-large"))
        concat(tag.br)
        concat(label)
      end
    end
  end
end

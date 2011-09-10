module ApplicationHelper
  
  
  def site_meta_title
    if @page && !@page.meta_title.empty?
      @page.meta_title
    else
      "Penang Hotel Mingood"
    end
  end
  
  
  def site_meta_keywords
    if @page && !@page.meta_keywords.empty?
      @page.meta_title
    else
      "Penang, Malaysia, Budget, Hotel, Wifi, ASTRO, Internet, Georgetown"
    end
  end
  
  
  def site_meta_description
    if @page && !@page.meta_description.empty?
      @page.meta_description
    else
      "Stay in the heart of Georgetown in a quiet street not far from the action, 
      at Hotel Mingood, a budget hotel with great service, free wifi and affordable facilities"
    end
  end
  
  def button_for(name, options={})
    return content_tag(:button, content_tag(:span, content_tag(:span, name)), :class => options[:class], :type => options[:button_type])
  end
   
end

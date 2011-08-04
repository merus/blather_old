module ApplicationHelper
  #Return the logo location

  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  #Return a specific title if one exists, and a default title otherwise
  def title
    base_title = "Blather"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end

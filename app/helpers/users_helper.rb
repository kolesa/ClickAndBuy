module UsersHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def share_with_facebook_url(opts)

    # Generates an url that will 'share with Facebook', and can includes title, url, summary, images without need of OG data.
    #
    # URL generate will be like
    # http://www.facebook.com/sharer.php?s=100&p[title]=We also do cookies&p[url]=http://www.wealsodocookies.com&p[images][0]=http://www.wealsodocookies.com/images/logo.jpg&p[summary]=Super developer company
    #
    # For this you'll need to pass the options as
    #
    # { :url     => "http://www.wealsodocookies.com",
    #   :title   => "We also do cookies",
    #   :images  => {0 => "http://imagelink"} # You can have multiple images here
    #   :summary => "My summary here"
    # }

    url = "http://www.facebook.com/sharer.php?s=100"

    parameters = []

    opts.each do |k,v|
      key = "p[#{k}]"

      if v.is_a? Hash
        v.each do |sk, sv|
          parameters << "#{key}[#{sk}]=#{sv}"
        end
      else
        parameters << "#{key}=#{v}"
      end

    end

    url + parameters.join("&")
  end
end

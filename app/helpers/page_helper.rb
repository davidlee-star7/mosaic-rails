module PageHelper

	 def content(c)
    	Shortcode.process(c)
  	 end

	 def content_html(c)
	   # raw content(c)
	   c = c.gsub("<pre>","").gsub("</pre>","")
	   raw Shortcode.process(c)
	 end

	 def connect_to_tableau
	 	 post_data = post_data = {
	      "username" => "phil@mosaicsustainability.com",
	      "password" => "Bison47!",
	      "client_ip" => "192.168.100.33"
	    }
	    server = "https://mosaic-tableau.com"
	    resp = Net::HTTP.post_form(URI.parse("#{server}/trusted"), post_data)
	    return resp.body
	 end

	 #
	 def list_row_type
	 	[
	 		{:id => 1,	:row_type =>"1",				:name => "one column"},
	 		{:id => 2,	:row_type => "1/2,1/2",			:name => "two half column"},
	 		{:id => 3,	:row_type => "1/2,1/4,1/4",		:name => "one half, two quarter"},
	 		{:id => 4,	:row_type => "1/4,1/4,1/2",		:name => "two quarter, one half"},
	 		{:id => 5,	:row_type => "1/4,1/4,1/4,1/4",	:name => "four quarter"},
	 		{:id => 6,	:row_type => "2/3,1/3",			:name => "one two third and one one third column"},
	 		{:id => 7,	:row_type => "1/3,2/3",			:name => "one one third and one two third"},
	 		{:id => 8,	:row_type => "1/3,1/3,1/3",		:name => "three  one third column"}
	 	]
	 end

end

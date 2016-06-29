module GroupsHelper

	def has_same_group res1, res2

	group1 = res1.groups.map{|g| g.id  }
	group2 = res2.groups.map{|g| g.id  }

	grouped = group1 & group2

		return 	grouped
		
	end

end

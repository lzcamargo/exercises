module FamilyPerson
	state do #family metamodel specified in two collections
		scratch :family_mm, [:class_name, :att_name]
		scratch :family_role_mm, [:role_name, :class_wh_part, :class_part]
	end
	state do # person metamodel specified in one collection
		scratch :person_mm, [:class_name, :att_name]
	end
	state do # source model specified in two collections 
		table :family, [:obj_name, :att_name, :att_instance]
		table :member, [:obj_name, :att_name, :att_instance, :att_anc_inst]
	end
	state do  
		scratch :member_gender, [:mg_name, :mg_role, :mg_fname] # collection used in helper
		table :person, [:obj_name, :att_name, :att_instance] # target collection
	end	
	
	bloom :heper_f2p do #helper for selecting the member genders 
		member_gender <= (person_mm * family_role_mm).pairs {|p, f| [p.class_name, f.role_name, p.att_name] if
		  (p.class_name == "Male" and (f.role_name == "father" or f.role_name == "sons"))}
			
		member_gender <= (person_mm * family_role_mm).pairs {|p, f| [p.class_name, f.role_name, p.att_name] if
		  (p.class_name == "Female" and (f.role_name == "mother" or f.role_name == "daugthers"))}	
	end
	
	bloom :family2person do # transformation rule
		person <= (member_gender * member).pairs(:mg_role => :obj_name) {|g, m| [g.fg_name, g.fg_fname, [m.att_instance,
			m.att_anc_inst].join(" ")]} 
  end
end	

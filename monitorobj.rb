require 'rubygems'
require 'bud'
require_relative 'family2personoo'

class Family
	attr_accessor :members, :lastName
	
	def initialize
		@members = []
		@lastName = lastName
	end
	
	def lastName
		@lastName
	end	
	
	def add_member(role, firstName)
		@members = Member.new(role, firstName) 
	end	
end

class Member
	attr_reader :role, :firstName 
	
	def initialize(role, firstName)
		@role = role 
		@firstName = firstName
	end	
end	

class Person
	attr_accessor :gender, :fullName
	
	def initialize
		@gender = gender
		@fullName = fullName
	end	
end	
	
module ObjectInstance
	include FamilyPerson
	#source and target metamodel instances in Bloom collections 
	def loadmetamodels
    family_mm <+ [["Family", "lastName"], 
		              ["Member", "lastName"]]
		
		family_role_mm <+ [["father","Family","Member"],
				 ["mother","Family","Member"],
		                   ["sons","Family","Member"],
		                   ["daugthers","Family","Member"]]
		
		person_mm <+ [["Person", "fullName"],
		              ["Male", "fullName"],
		              ["Female", "fullName"]]
	end

	def bloom_instance
		#Family Objects instantiated (two families, last names and members
		family1 = Family.new()
		family1.lastName = "March"
		family1.members = [["father","Jim"],["mother","Cindy"],
											["sons","Brandon"],["daughters","Brenda"]]
	
		family2 = Family.new()
		family2.lastName = "Sailor"
		family2.members = [["father","Peter"],["mother","Jackie"],
											["sons","David"], ["sons","Dylan"],
											["daughters","Kelly"]]

    #Family Objects inserted into Bloom member collections
		for i in (0..family1.members.length - 1) 
			member <+ [[family1.members[i][0], family1.members[i][1], family1.lastName]]
		end	
		
		for i in (0..family2.members.length - 1) 
			member <+ [[family2.members[i][0], family2.members[i][1], family2.lastName]]  
		end			
	end	
end


class MonitorObject
	include Bud
	include ObjectInstance
	
end

m = MonitorObject.new
m.loadmetamodels
m.bloom_instance
m.tick

m.person.each do |p| 
	pn  = Person.new
	pn.gender = p.obj_name
  pn.fullName = p.att_instance
end	


objs = []
ObjectSpace.each_object(Person) do |o|
  objs << o
	puts objs.inspect
end


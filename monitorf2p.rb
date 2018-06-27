require 'rubygems'
require 'bud'
require_relative 'family2person2'
module MonitorF2P
	
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
	def loadmodels
		family <+ [["Family","lastName","March"],
		           ["Family","lastName","Sailor"]]
		
		member <+ [["father","firstName","Jim","March" ],
		           ["mother","firstName","Cindy","March"],
							 ["sons","firstName","Brandon","March"],
							 ["daughters","firstName","Brenda","March"],
               ["father","firstName","Peter","Sailor"],
							 ["mother","firstName","Jackie","Sailor"],
							 ["sons","firstName","David","Sailor"],
							 ["sons","firstName","Dylan","Sailor"],
							 ["daughters","firstName","Kelly","Sailor"]]
  end	
end

class Monitor
	include Bud
	include FamilyPerson
	include MonitorF2P
end
cm = Monitor.new
cm.loadmetamodels
cm.loadmodels
cm.tick
cm.person {|p| puts p.inspect} 

#cm.family_mm {|f| puts f.inspect} 
#cm.person_mm {|p| puts p.inspect}
#cm.family_role_mm {|r| puts r.inspect} 
#cm.family {|f| puts f.inspect} 
#cm.member {|m| puts m.inspect}

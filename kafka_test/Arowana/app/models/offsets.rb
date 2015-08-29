module Arowana
    module DBModel
        
        class Offsets < Sequel::Model(:offsets)
    
            def Offsets.getOffsetByTopic(tp)
                Offsets[:topic => tp]
            end

            def Offsets.updateOffsetByTopic(tp, offset_val)
                Offsets.where("topic = '#{tp}'").update(:offset_id => offset_val)
            end
    
        end
    end
end
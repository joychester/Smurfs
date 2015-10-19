module Arowana
    module DBModel
        
        class Offsets < Sequel::Model(:offsets)
    
            def Offsets.getOffsetByTopic(tp)
                Offsets[:topic => tp]
            end

            def Offsets.updateOffsetByTopic(tp, offset_val)
                Offsets.where("topic = '#{tp}'").update(:offset_id => offset_val)
            end
            
            #create a new topic record in offset table
            def Offsets.insertOffsetByTopic(tp, partition)
                Offsets.insert(:topic => tp, :partition_id => partition, :offset_id => 0)
            end

        end
    end
end
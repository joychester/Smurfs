module Arowana
    module DBModel
        
        class UserTiming < Sequel::Model(:user_timing)

			#batch insert to the dashboard table to 'real-time' report
			#DB[:table].import([:x, :y], [[1, 2], [3, 4]])

            def UserTiming.batchInsertByTopic(tp, data)
                #DO NOT use UserTiming.columns
            	insert_columns = DB[:user_timing].columns

                # remove the :id column, why called twice from chrome??
                insert_columns.shift
            	DB[:user_timing].import(insert_columns, data)
            end
    
        end
    end
end
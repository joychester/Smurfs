require 'date'
module Arowana
    module DBModel
        
        class UserTiming < Sequel::Model(:user_timing)

			#batch insert to the dashboard table to 'real-time' report
			#DB[:table].import([:x, :y], [[1, 2], [3, 4]])

            def UserTiming.batchInsert(data)
                #DO NOT use UserTiming.columns
            	insert_columns = DB[:user_timing].columns

                # remove the :id column, why called twice from chrome??
                p insert_columns.shift
                p data
            	DB[:user_timing].import(insert_columns, data)
            end
    
            def UserTiming.getAllTags(env_name)
                dataset = DB["select DISTINCT ON (tag) tag from user_timing where env_name = '#{env_name}'"]
                return dataset.map(:tag)
            end

            def UserTiming.getRespByTag(env_name, t_tag, count=200)
                dataset = DB["select resp_time from user_timing where tag = '#{t_tag}' and env_name = '#{env_name}' order by id desc limit #{count}"]
                resp_time = dataset.map(:resp_time).map{|item| item/1000.0}
                return resp_time.reverse!
            end

            def UserTiming.getDateByTag(env_name, t_tag, count=200)
                dataset = DB["select test_date from user_timing where tag = '#{t_tag}' and env_name = '#{env_name}' order by id desc limit #{count}"]
                time_stamp =  dataset.map(:test_date).map{|item| 
                    item = DateTime.strptime((item.to_i/1000).to_s,'%s').to_s
                    item.sub!(/\+00:00/, "")}

                return time_stamp.reverse!
            end

            def UserTiming.getLatestURLByTag(env_name, t_tag)
                p dataset = DB["select test_url from user_timing where tag = '#{t_tag}' and env_name = '#{env_name}' order by id limit 1"]
                return dataset.map(:test_url)
            end
        end
    end
end
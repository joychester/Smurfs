module Arowana
  module Page
    class ResultsCenterUnifiedDesktopTrendPage < BasePage
      get '/pagetrend' do
        @env_name = params[:env]
        @page_name = params[:tag]

        @test_url = Arowana::DBModel::UserTiming.getLatestURLByTag(@env_name, @page_name).fetch(0)

        @page_data = []
        @page_data.concat(Arowana::DBModel::UserTiming.getRespByTag(@env_name, @page_name))

        @data_time = []
        @data_time.concat(Arowana::DBModel::UserTiming.getDateByTag(@env_name, @page_name))


        haml :index
      end

      get '/listtags' do 
        @env_name = params[:env_name]
        @tags = Arowana::DBModel::UserTiming.getAllTags(@env_name)

        haml :tags
      end

      get '/' do
        redirect '/listtags?env_name=slce003'
      end
    end
  end
end
# encoding: utf-8

module Ears
  class App < Sinatra::Base
    
    configure(:production, :development) do
      enable :logging
    end
  
    get('/') { "Hello from Ears!" }
    
    get('/duration') do
      content_type :json
      
      begin
        audio_uri = CGI.unescape(params[:audio_uri])
        audio_uri.gsub!(/\s/, '+')
        p [:audio_uri, audio_uri]

        details = Open3.popen3("#{FFMBC} -i '#{audio_uri}'"){|i,o,e,t| p e.read.chomp }
        
        matches = details.match(/Duration: (\d\d:\d\d:\d\d)/im)
        raise RuntimeError.new("Could not obtain a duration from Uri") if matches.nil?

        duration = matches[1]

        JSON.generate({:result => {:uri => audio_uri, :duration => duration}})
      rescue RuntimeError => e
        status(400)
        JSON.generate({:result => {:uri => audio_uri, :error => e.message, :ffmbc_output => details}})
      end
    end
  end
end
module Linkedin
  class Profile      
      private
      def http_client
        byebug
        puts "*******************http_client**********************"
        @http_client ||= Mechanize.new do |agent|
      agent.user_agent = Linkedin::UserAgent.randomize
      agent.set_proxy("176.31.174.1", 9999)

      if !@options.empty?
        agent.set_proxy(@options[:proxy_ip], @options[:proxy_port], @options[:username], @options[:password])
        agent.open_timeout = @options[:open_timeout]
        agent.read_timeout = @options[:read_timeout]
      end
      agent.max_history = 0
    end
  end
end
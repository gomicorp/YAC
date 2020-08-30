require 'json'
require 'faraday'
require 'awesome_print'
require 'awesome_print/colorize'

require_relative 'helper'

namespace :ngrok do
  def comment(content)
    puts "* #{content}".gray
  end

  desc 'start ngrok sample app'
  task start: :environment do
    raise '이 task 는 development 환경에서만 실행 할 수 있습니다.' unless Rails.env.development?

    comment'새로 생성된 프록시 주소를 읽어옵니다.'
    res = Faraday.get('http://localhost:4040/api/tunnels')
    body = JSON.parse(res.body, object_class: OpenStruct)
    tunnel = body.tunnels.select { |tunnel| tunnel.proto == 'https' }.first
    proxy_host = tunnel.public_url.gsub('https://', '')

    comment'.env 의 PROXY_URL 환경변수 값을 교체합니다.' \
      "\n" \
      "\n\tPROXY_URL=#{proxy_host}" \
      "\n\tMock site: #{tunnel.public_url}/mock/posts" \
      "\n"
    env_path = Rails.root.join('.env')
    env_text = File.read(env_path)
    env_text.gsub!(/PROXY_URL=.*io/, "PROXY_URL=#{proxy_host}")
    File.open(env_path, 'w') { |f| f.puts env_text }

    comment 'mock 데이터를 세팅합니다.'
    rake 'yac:sampled'

    comment '앱을 실행합니다.'
    pid_path = Rails.root.join('tmp/pids/server.pid')
    File.exists?(pid_path) ? rake('restart') : rake('server')

  rescue Faraday::ConnectionFailed
    puts "\n4040 포트에서 실행 중인 ngrok 를 인식할 수 없습니다. 먼저 ngrok 를 실행해주세요. \n" \
      "\n\tngrok http 3000\n\n"
  end
end

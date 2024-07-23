class Rack::Attack
  # Кеш за Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Ограничаване на броя заявки от един IP адрес
  throttle('req/ip', limit: 5, period: 1.minute) do |req|
    req.ip
  end

  # Кастомизиран респондер за throttled заявки
  self.throttled_responder = lambda do |env|
    [429, {}, ['Throttled']]
  end
end

ActiveSupport::Notifications.subscribe("rack.attack") do |name, start, finish, request_id, payload|
  req = payload[:request]
  Rails.logger.info "[Rack::Attack][#{req.ip}] #{req.path} throttled: #{req.env['rack.attack.match_type']}"
end

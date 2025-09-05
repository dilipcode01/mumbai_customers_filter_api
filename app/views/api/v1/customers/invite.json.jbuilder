json.array! @customers do |customer|
  json.user_id customer[:user_id]
  json.name customer[:name]
end

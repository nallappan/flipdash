#current_valuation = 0

#SCHEDULER.every '2s' do
#  last_valuation = current_valuation
#  current_valuation = rand(100)

#  send_event('valuation', { current: current_valuation, last: last_valuation })
#end

current = 0

SCHEDULER.every '5s' do
  last     = current
  current     = rand(100)

  send_event('bar', { current: current, last: last })
end

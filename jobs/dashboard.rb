SCHEDULER.every '2s' do

status= ['ok', 'warning', 'critical']

value = rand(100)

 if value > 80
	send_event('hot', { state: status[2], message: value })

 elsif value > 70
	send_event('hot', { state: status[1], message: value })
 else
	send_event('hot', { state: status[0], message: value })
 end
end

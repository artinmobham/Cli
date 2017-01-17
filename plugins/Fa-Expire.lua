	local function pre_process(msg)
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', get_receiver(msg))
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) and not is_sudo(msg) then
		if msg.text:match('!') then
			return send_large_msg(get_receiver(msg), '📆این گروه منقضی شده است اقدام به شارژ آن کنید.\n@Ev_Cnt_Bot')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
		if redis:hget('expires0',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۰ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires0',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 1 then
		if redis:hget('expires1',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۱ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires1',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۲ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires2',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 3 then
		if redis:hget('expires3',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۳ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires3',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 4 then
		if redis:hget('expires4',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۴ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires4',msg.to.id,'5')
	end
	if tonumber(timetoexpire) == 5 then
		if redis:hget('expires5',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '🔆۵ روز از انقضای گروه باقی مانده\nگروه خود را شارژ کنید')
		redis:hset('expires5',msg.to.id,'5')
	end
end
return msg
end
function run(msg, matches)
	if matches[1]:lower() == 'تنظیم انقضا' then
		if not is_sudo(msg) then return end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		return "🔋گروه شارژ شد\n🔖به مدت "..matches[2].." روز"
	end
	if matches[1]:lower() == 'انقضای گروه' then
		local expiretime = redis:hget ('expiretime', get_receiver(msg))
		if not expiretime then return '📈تاریخ انقضای گروه هنوز تنظیم نشده است.' else
			local now = tonumber(os.time())
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " روز باقی مانده است🔱"
		end
	end

end
return {
  patterns = {
    "^تنظیم انقضا (.*)$",
	"^انقضای گروه$",
  },
  run = run,
  pre_process = pre_process
}

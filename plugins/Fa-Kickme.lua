local function run(msg, matches)
if matches[1] == 'اخراج من' then
local hash = 'kick:'..msg.to.id..':'..msg.from.id
     redis:set(hash, "waite")
      return '🔖کاربر ('..msg.from.username..') شما درخواست خروج از گروه کرده اید\n🔵برای تایید بله\nو\n🔴برای رد کردن خیر را بفرستید'
    end

    if msg.text then
	local hash = 'kick:'..msg.to.id..':'..msg.from.id
      if msg.text:match("^بله$") and redis:get(hash) == "waite" then
	  redis:set(hash, "ok")
	elseif msg.text:match("^خیر$") and redis:get(hash) == "waite" then
	send_large_msg(get_receiver(msg), "📛درخواست شما رد شد")
	  redis:del(hash, true)

      end
    end
	local hash = 'kick:'..msg.to.id..':'..msg.from.id
	 if redis:get(hash) then
        if redis:get(hash) == "ok" then
         channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false)
         return '❌کاربر از گروه  ('..msg.to.title..') خارج شد'
        end
      end
    end

return {
  patterns = {
  "^اخراج من",
  "^بله$",
  "^خیر$"
  },
  run = run,
}

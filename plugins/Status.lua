local function run(msg, matches)
local text = io.popen("sh ./core/status.sh"):read('*all')
if is_sudo(msg) then
  return text
end
  end
return {
  patterns = {
    '^[!/]status$'
  },
  run = run,
  moderated = true
}

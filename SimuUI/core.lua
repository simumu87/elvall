local modules = {
  "Modules/KeyStyle.lua",
  "Modules/QuickFocus.lua"
}

for _, modulePath in ipairs(modules) do
  local success, chunk = pcall(loadfile, modulePath)
  if success and type(chunk) == "function" then
    local ok, err = pcall(chunk)
    if not ok then
      print("SimuUI: 모듈 실행 중 오류 -", err)
    end
  else
    print("SimuUI: 모듈 로딩 실패 -", tostring(chunk))
  end
end

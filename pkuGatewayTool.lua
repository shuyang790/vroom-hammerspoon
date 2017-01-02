modal = hs.hotkey.modal.new('cmd-alt-ctrl', 'P')
local url = "https://its.pku.edu.cn/cas/ITSClient"
local accountFile = os.getenv("HOME") .. "/.hammerspoon/.pkuAccount"

function fileExists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function setAccount()
  if not fileExists(accountFile) then return {} end
  lines = {}
  for line in io.lines(accountFile) do
    lines[#lines + 1] = line
  end
  username = lines[1]
  password = lines[2]
end

function setHeaders()
  headers = {}
  headers["Content-Type"] = "application/x-www-form-urlencoded"
  headers["Accept"] = "*/*"
  headers["app"] = "IPGWiOS1.2"
end

setHeaders()
setAccount()

function modal:entered()
  hs.alert'PKU Gateway mode: Enter'
end

function modal:exited()
  hs.alert'PKU Gateway mode: Exit'
end

modal:bind({'cmd', 'alt', 'ctrl'}, 'P', function()
  modal:exit()
end)

modal:bind({'ctrl', 'alt', 'cmd'}, 'C', function()
  hs.alert("connecting...")
  connectGateway()
end)

modal:bind({'ctrl', 'alt', 'cmd'}, 'D', function()
  hs.alert("Disconnecting...")
  disConnectAll()
end)

function connectGateway()
  bodyString = "username=" .. username
    .. "&password=" .. password
    .. "&cmd=open"
    .. "&iprange=fee"
  hs.http.asyncPost(
    url,
    bodyString,
    headers,
    function (statusCode, responseBody, responseHeader)
      hs.alert.show(
        "PKU Gateway Connect: " .. statusCode .. "\n"
        .. responseBody:gsub(',', ',\n'),
        5
      )
    end
  )
end

function disConnectAll()
  bodyString = "username=" .. username
    .. "&password=" .. password
    .. "&cmd=close"
  hs.http.asyncPost(
    url,
    bodyString,
    headers,
    function (statusCode, responseBody, responseHeader)
      hs.alert.show(
        "PKU Gateway Disconnect All: " .. statusCode .. "\n"
        .. responseBody:gsub(',', ',\n'),
        5
      )
    end
  )
end

local function getProcDir()
    local i = 0
    while arg[i] ~= nil do
        i = i - 1
    end
    return arg[i + 1]:match("(.+)[/\\][%w_.-]+$")
end
__Target__ = getProcDir()
__EXT__ = package.cpath:match '[/\\]%?%.([a-z]+)'
package.path = './test/?.lua'
package.cpath = ('%s/?.%s'):format(__Target__, __EXT__)

--local platform = require 'bee.platform'
--if platform.Compiler == 'msvc' then
--    dofile './3rd/luaffi/src/test.lua'
--end

local lu = require 'luaunit'

require 'test_lua'
require 'test_platform'
require 'test_serialization'
require 'test_filesystem'
require 'test_thread'
require 'test_subprocess'
require 'test_socket'
require 'test_filewatch'
--require 'test_registry'

os.exit(lu.LuaUnit.run(), true)

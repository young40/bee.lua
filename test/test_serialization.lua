local lu = require 'luaunit'

local seri = require 'bee.serialization'

local function TestEq(...)
    lu.assertEquals(
        table.pack(seri.unpack(seri.pack(...))),
        table.pack(...)
    )
    lu.assertEquals(
        table.pack(seri.unpack(seri.packstring(...))),
        table.pack(...)
    )
end

local function TestErr(msg, ...)
    lu.assertErrorMsgEquals(msg, seri.pack, ...)
    lu.assertErrorMsgEquals(msg, seri.packstring, ...)
end

test_seri = {}

function test_seri:test_ok_1()
    TestEq(1)
    TestEq(0.0001)
    TestEq('TEST')
    TestEq(true)
    TestEq(false)
    TestEq({})
    TestEq({1, 2})
    TestEq(1, {1, 2})
    TestEq(1, 2, {A={B={C='D'}}})
    TestEq(1, nil, 2)
end

function test_seri:test_err_1()
    TestErr("Unsupport type function to serialize", function() end)
end

function test_seri:test_err_2()
    TestErr("Unsupport type thread to serialize", coroutine.create(function() end))
end

function test_seri:test_err_3()
    TestErr("Unsupport type userdata to serialize", io.stdout)
end

function test_seri:test_err_4()
    local t = {}
    t.a = t
    TestErr("serialize can't pack too depth table", t)
end

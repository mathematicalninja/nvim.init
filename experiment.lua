local one = {}
local two = { str = "nope" }

function one.p(T)
    print("one.p")
    T:p()
end

function two:p()
    print("two.p")
    print(self.str)
end

function two:op()
    one.p(self)
end

--------------------------------------------------------------------------------

local three = { str = "three here!" }
local four = { str = "four here!" }

function three:p(F4)
    print("-----")
    print("F4")
    print(self.str)
    print(F4.str)
    print("-----")
end

function four:p(T3)
    print("-----")
    print("T3")
    print(self.str)
    print(T3.str)
    print("-----")
end

local function fCall()
    four:p(three)
end

local function tCall()
    three:p(four)
end
tCall()
fCall()

--------------------------------------------------------------------------------

--- @type fun(self, t)
--- @param t {str:string}
local function p(t)
    print(t.str)
end
--- @class Test1
local test1 = {}
--- @type fun(self:Test1, t2: Test2)
function test1:p(t2)
    print("here")
end
--- @class Test2
local test2 = {}
function test2.p(t1)
    print("here")
end
local v = test1

local m = test2

--------------------------------------------------------------------------------
--- @class T
--- @field str string
--- @field p fun(self:T, other: T)

--- @type T
--- @diagnostic disable-next-line
local T = {}

function T:p(other)
    --    print(T.str)
    other:p(T) ---- NOTE: infinite callback here, do not execute.
end
--------------------------------------------------------------------------------
-- check.lua
local check = {}

function check.valid(Float)
    return Float.state.valid
end

-- state.lua
local state = {}
state.valid = "state is valid"

local Float = {
    state = state,
    check = check,
}

-- main.lua
print(Float.check.valid(Float)) -- no need to pass Float

--------------------------------------------------------------------------------

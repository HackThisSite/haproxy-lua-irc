--
-- haproxy-lua-irc.lua
--
-- HAProxy as an IRC load balancer with client IP pass-through
--
-- Version:  0.1.0
-- Download: https://github.com/HackThisSite/haproxy-lua-irc
--
-- MIT License
--
-- Copyright (c) 2019 HackThisSite
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.
--

local _author    = "HackThisSite Staff <staff@hackthissite.org>"
local _copyright = "Copyright 2019 HackThisSite"
local _version   = "0.1.0"

local function main(txn)
-- TODO: Flesh out pseudo code and fill in the rest
  local cnt = txn.f:src_get_gpc0
  if cnt == 0 and txn.linebeg == "PROXY" then
    txn.res:set()
    txn.f:src_inc_gpc0
  elseif cnt == 0 and txnlinebeg != "PROXY" then
    fail here, HAProxy missing send-proxy[-v2] setting
  elseif cnt == 1 and txn.has_data and txn.linebeg != "PROXY" then
    local data = txn.res:getline()
    txn.res:set("WEBIRC ...\n" .. data)
-- or
    txn.res:set()
    txn.res:send("WEBIRC ...\n" .. data)
    txn.f:src_inc_gpc0
  end
end

core.register_action("irc", {"tcp-res"}, main)

-- EOF

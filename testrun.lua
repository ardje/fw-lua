#!/usr/bin/lua
local src=arg[1] or "."
local dst=arg[2] or src
rulesdir=src.."/rules"
scriptsdir=dst.."/scripts"
dofile("firewall.lua")

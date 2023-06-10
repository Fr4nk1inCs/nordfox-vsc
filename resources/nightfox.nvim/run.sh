#!/usr/bin/env bash

nvim --headless -c "luafile dayfox.lua" -c "qa"
node ./run.js

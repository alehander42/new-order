import macros, strutils, sequtils, tables, os

const BLUE_MONDAY_URL* = "https://www.youtube.com/watch?v=FYH8DsU2WCk"

macro neworder*(code: untyped): untyped =
  result = code
  result[^1] = nnkStmtList.newTree()
  result[^1].add quote do:
    when defined(linux):
      discard execShellCmd("sensible-browser " & BLUE_MONDAY_URL)
    elif defined(windows):
      discard execShellCmd("start " & BLUE_MONDAY_URL)
    elif defined(osx):
      discard execShellCmd("open " & BLUE_MONDAY_URL)
    else:
      discard
  for child in code[^1]:
    result[^1].add(child)
  echo result.repr

export os
  


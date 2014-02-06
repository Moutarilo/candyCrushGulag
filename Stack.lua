Class = require 'middleclass'

Stack = Class('Stack')

function Stack:initialize()
  self.data = {}
end

function Stack:push(item)
  table.insert(self.data, item)
end

function Stack:peek()
  return self.data[#self.data]
end

function Stack:pop()
  --ret = self.data[#self.data]
  table.remove(self.data, #self.data)
  --return ret
end

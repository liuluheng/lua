Account = { balance=0,

            withdraw = function (self, v)
                self.balance = self.balance - v
            end
}

function Account:deposit (v)
    self.balance = self.balance + v
end

function Account:new (o)
    o = o or {}
    -- create table if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

a = Account:new{balance = 0}
print(a.balance)

a:deposit(100.00)
print(a.balance)

a:withdraw(40.00)
print(a.balance)


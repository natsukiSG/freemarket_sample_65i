class Transaction < ActiveHash::Base
  self.data = [
      {id: 1, name: '販売中'}, {id: 2, name: '売り切れ'}
  ]
end
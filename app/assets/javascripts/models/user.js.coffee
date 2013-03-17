Beech.User = DS.Model.extend
  id: DS.attr('number')
  email: DS.attr('string')
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')
  alreadyFollowing: DS.attr('boolean')
  checks: DS.hasMany('Beech.Check')

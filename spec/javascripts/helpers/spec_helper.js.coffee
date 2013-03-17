
window.model = (model) ->
  should =
    should:
      have:
        attribute: (name, type) ->
          describe '', ->
            beforeEach ->
              @meta = model.metaForProperty name
              console.log @meta
              expect(@meta).toBeDefined()

            it "should have #{name} attribute", ->
              expect(@meta.isAttribute).toBeTruthy()

            if type?
              describe "#{model}##{name} attribute", ->
                it 'should have type #{type}', ->
                  expect(@meta.type).toBe(type)


          should
      belongsTo: (association) ->
        as: (property) ->
          describe '', ->
            beforeEach ->
              @meta = model.metaForProperty property
              expect(@meta).toBeDefined()

            it "should belongs to #{association}", ->
              expect(@meta.isRelationship).toBeTruthy()
              expect(@meta.kind).toBe('belongsTo')
              expect(@meta.type).toBe(association.toString())

          should
      haveMany: (association) ->
        as: (property) ->
          describe '', ->
            beforeEach ->
              @meta = model.metaForProperty property
              expect(@meta).toBeDefined()

            it "should have many #{association} as #{property}", ->
              expect(@meta.isRelationship).toBeTruthy()
              expect(@meta.kind).toBe('hasMany')
              expect(@meta.type).toBe(association.toString())


          should

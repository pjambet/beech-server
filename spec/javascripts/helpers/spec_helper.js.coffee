
window.model = (model) ->
  should =
    should:
      have:
        attribute: (name, type) ->
          describe "##{name}", ->
            beforeEach ->
              @meta = model.metaForProperty name
              console.log @meta
              expect(@meta).toBeDefined()

            it "should be an attribute", ->
              expect(@meta.isAttribute).toBeTruthy()

            if type?
              it "should have type #{type}", ->
                expect(@meta.type).toBe(type)


          should
      belongsTo: (association) ->
        as: (property) ->
          describe "##{property}", ->
            beforeEach ->
              @meta = model.metaForProperty property
              expect(@meta).toBeDefined()

            it "should be a belongs to #{association} association", ->
              expect(@meta.isRelationship).toBeTruthy()
              expect(@meta.kind).toBe('belongsTo')
              expect(@meta.type).toBe(association.toString())

          should
      haveMany: (association) ->
        as: (property) ->
          describe "##{property}", ->
            beforeEach ->
              @meta = model.metaForProperty property
              expect(@meta).toBeDefined()

            it "should be a has many #{association} association", ->
              expect(@meta.isRelationship).toBeTruthy()
              expect(@meta.kind).toBe('hasMany')
              expect(@meta.type).toBe(association.toString())


          should

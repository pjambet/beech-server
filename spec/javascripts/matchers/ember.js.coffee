beforeEach ->
  @addMatchers
    toBeAnInstanceOf: (expectedInstance) ->
      expectedInstance.detectInstance @actual

    toExtend: (expectedClass) ->
      expectedClass.detect @actual

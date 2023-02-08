return {
  BlockSelector = {
    avg = 3813700,
    functions = {
      instantiate = {
        avg = 155515,
        max = 156830,
        min = 139730,
        ncalls = 13,
      },
      produceBlock = {
        avg = 61659,
        max = 62801,
        min = 59958,
        ncalls = 8,
      },
    },
  },
  BlockSelectorV2 = {
    avg = 864660,
    functions = {
      instantiate = {
        avg = 155859,
        max = 157174,
        min = 140074,
        ncalls = 13,
      },
      produceBlock = {
        avg = 51410,
        max = 52524,
        min = 49635,
        ncalls = 8,
      },
    },
  },
  Difficulty = {
    avg = 150550,
  },
  Eligibility = {
    avg = 282066,
  },
  PoS = {
    avg = 1511532,
    functions = {
      instantiate = {
        avg = 477258,
        max = 480374,
        min = 463250,
        ncalls = 11,
      },
      produceBlock = {
        avg = 113748,
        ncalls = 2,
      },
      terminate = {
        avg = 49699,
        ncalls = 1,
      },
    },
  },
  PoSV2Aux = {
    avg = 2390967,
    functions = {
      _produceBlockGas = {
        avg = 79003,
        max = 80273,
        min = 77313,
        ncalls = 50,
      },
      adjustDifficultyGas = {
        avg = 29968,
        max = 31185,
        min = 28419,
        ncalls = 50,
      },
      canProduceBlockGas = {
        avg = 33110,
        max = 33234,
        min = 33005,
        ncalls = 50,
      },
      produceBlock = {
        avg = 113055,
        max = 115744,
        min = 112824,
        ncalls = 50,
      },
      recordBlockGas = {
        avg = 131279,
        max = 134308,
        min = 111156,
        ncalls = 50,
      },
    },
  },
  PoSV2FactoryImpl = {
    avg = 2535154,
    functions = {
      createNewChain = {
        avg = 1980246,
        ncalls = 4,
      },
    },
  },
  PoSV2Impl = {
    avg = 2113813,
    functions = {
      produceBlock = {
        avg = 112913,
        max = 112980,
        min = 112880,
        ncalls = 3,
      },
      terminate = {
        avg = 42026,
        ncalls = 1,
      },
    },
  },
  RewardManager = {
    avg = 341685,
    functions = {
      reward = {
        avg = 34775,
        ncalls = 1,
      },
    },
  },
  RewardManagerV2Impl = {
    avg = 734676,
    functions = {
      reward = {
        avg = 48133,
        max = 50404,
        min = 48034,
        ncalls = 54,
      },
    },
    max = 734679,
    min = 734667,
  },
  StakingImpl = {
    avg = 626264,
    functions = {
      stake = {
        avg = 81610,
        max = 90287,
        min = 53453,
        ncalls = 24,
      },
      unstake = {
        avg = 63186,
        max = 75093,
        min = 36093,
        ncalls = 11,
      },
      withdraw = {
        avg = 43450,
        max = 47450,
        min = 42650,
        ncalls = 6,
      },
    },
    max = 626268,
    min = 626220,
  },
}

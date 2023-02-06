return {
  BlockSelector = {
    avg = 3815242,
    functions = {
      instantiate = {
        avg = 155515,
        max = 156830,
        min = 139730,
        ncalls = 13,
      },
      produceBlock = {
        avg = 61677,
        max = 62819,
        min = 59976,
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
        avg = 51406,
        max = 52542,
        min = 49558,
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
        avg = 79021,
        max = 80292,
        min = 77324,
        ncalls = 50,
      },
      adjustDifficultyGas = {
        avg = 29968,
        max = 31185,
        min = 28419,
        ncalls = 50,
      },
      canProduceBlockGas = {
        avg = 33128,
        max = 33224,
        min = 33025,
        ncalls = 50,
      },
      produceBlock = {
        avg = 113052,
        max = 115835,
        min = 112764,
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
        avg = 112925,
        max = 112932,
        min = 112921,
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

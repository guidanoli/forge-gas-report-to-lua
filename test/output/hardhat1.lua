return {
  BlockSelector = {
    deployment = {
      avg = 3815242,
    },
    functions = {
      instantiate = {
        avg = 155515,
        max = 156830,
        min = 139730,
        ncalls = 13,
      },
      produceBlock = {
        avg = 61649,
        max = 62819,
        min = 59985,
        ncalls = 8,
      },
    },
  },
  BlockSelectorV2 = {
    deployment = {
      avg = 864660,
    },
    functions = {
      instantiate = {
        avg = 155859,
        max = 157174,
        min = 140074,
        ncalls = 13,
      },
      produceBlock = {
        avg = 51411,
        max = 52533,
        min = 49531,
        ncalls = 8,
      },
    },
  },
  Difficulty = {
    deployment = {
      avg = 150550,
    },
  },
  Eligibility = {
    deployment = {
      avg = 282066,
    },
  },
  PoS = {
    deployment = {
      avg = 1511532,
    },
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
    deployment = {
      avg = 2390967,
    },
    functions = {
      _produceBlockGas = {
        avg = 79003,
        max = 80270,
        min = 77293,
        ncalls = 50,
      },
      adjustDifficultyGas = {
        avg = 29968,
        max = 31185,
        min = 28419,
        ncalls = 50,
      },
      canProduceBlockGas = {
        avg = 33111,
        max = 33202,
        min = 33025,
        ncalls = 50,
      },
      produceBlock = {
        avg = 113067,
        max = 115684,
        min = 112884,
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
    deployment = {
      avg = 2535154,
    },
    functions = {
      createNewChain = {
        avg = 1980246,
        ncalls = 4,
      },
    },
  },
  PoSV2Impl = {
    deployment = {
      avg = 2113813,
    },
    functions = {
      produceBlock = {
        avg = 112917,
        max = 112921,
        min = 112910,
        ncalls = 3,
      },
      terminate = {
        avg = 42026,
        ncalls = 1,
      },
    },
  },
  RewardManager = {
    deployment = {
      avg = 341685,
    },
    functions = {
      reward = {
        avg = 34775,
        ncalls = 1,
      },
    },
  },
  RewardManagerV2Impl = {
    deployment = {
      avg = 734676,
      max = 734679,
      min = 734667,
    },
    functions = {
      reward = {
        avg = 48133,
        max = 50404,
        min = 48034,
        ncalls = 54,
      },
    },
  },
  StakingImpl = {
    deployment = {
      avg = 626264,
      max = 626268,
      min = 626220,
    },
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
  },
}

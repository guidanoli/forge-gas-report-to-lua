return {
  Difficulty = {
    deployment = {
      avg = 110563,
      size = 505,
    },
    functions = {
      getNewDifficulty = {
        avg = 21715,
        max = 21718,
        median = 21718,
        min = 21681,
        ncalls = 2513,
      },
    },
  },
  Eligibility = {
    deployment = {
      avg = 218267,
      size = 1043,
    },
    functions = {
      whenCanProduceBlock = {
        avg = 25992,
        max = 28535,
        median = 25995,
        min = 21489,
        ncalls = 162518,
      },
    },
  },
  PoSV2Impl = {
    deployment = {
      avg = 1928158,
      size = 10362,
    },
    functions = {
      ["produceBlock(uint256)(bool)"] = {
        avg = 38482,
        max = 58069,
        median = 38466,
        min = 35645,
        ncalls = 1000,
      },
      ["produceBlock(uint32,bytes)(bool)"] = {
        avg = 129474,
        max = 157602,
        median = 128964,
        min = 106074,
        ncalls = 1001,
      },
    },
  },
  RewardManagerV2Impl = {
    deployment = {
      avg = 649080,
      size = 3558,
    },
    functions = {
      ["reward(uint32,address)"] = {
        avg = 25012,
        max = 25016,
        median = 25016,
        min = 21626,
        ncalls = 1002,
      },
      ["reward(uint32[])"] = {
        avg = 58027,
        max = 94198,
        median = 55488,
        min = 28182,
        ncalls = 12,
      },
    },
  },
  UnrolledCordic = {
    deployment = {
      avg = 337380,
      size = 1638,
    },
    functions = {
      log2Times1e18 = {
        avg = 23489,
        max = 23668,
        median = 23491,
        min = 23291,
        ncalls = 162475,
      },
    },
  },
}

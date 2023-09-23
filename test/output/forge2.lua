return {
  Difficulty = {
    deployment = {
      avg = 89563,
      size = 505,
    },
    functions = {
      getNewDifficulty = {
        avg = 715,
        max = 718,
        median = 718,
        min = 681,
        ncalls = 2513,
      },
    },
  },
  Eligibility = {
    deployment = {
      avg = 197267,
      size = 1043,
    },
    functions = {
      whenCanProduceBlock = {
        avg = 4992,
        max = 7535,
        median = 4995,
        min = 489,
        ncalls = 162518,
      },
    },
  },
  PoSV2Impl = {
    deployment = {
      avg = 1907158,
      size = 10362,
    },
    functions = {
      ["produceBlock(uint256)(bool)"] = {
        avg = 17482,
        max = 37069,
        median = 17466,
        min = 14645,
        ncalls = 1000,
      },
      ["produceBlock(uint32,bytes)(bool)"] = {
        avg = 108474,
        max = 136602,
        median = 107964,
        min = 85074,
        ncalls = 1001,
      },
    },
  },
  RewardManagerV2Impl = {
    deployment = {
      avg = 628080,
      size = 3558,
    },
    functions = {
      ["reward(uint32,address)"] = {
        avg = 4012,
        max = 4016,
        median = 4016,
        min = 626,
        ncalls = 1002,
      },
      ["reward(uint32[])"] = {
        avg = 37027,
        max = 73198,
        median = 34488,
        min = 7182,
        ncalls = 12,
      },
    },
  },
  UnrolledCordic = {
    deployment = {
      avg = 316380,
      size = 1638,
    },
    functions = {
      log2Times1e18 = {
        avg = 2489,
        max = 2668,
        median = 2491,
        min = 2291,
        ncalls = 162475,
      },
    },
  },
}

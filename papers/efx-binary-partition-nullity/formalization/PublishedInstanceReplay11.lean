import PublishedInstanceReplay10

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_01001100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_76 = true := by
  decide +kernel

theorem checked_01001101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_77 = true := by
  decide +kernel

theorem checked_01001110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_78 = true := by
  decide +kernel

theorem checked_01001111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_79 = true := by
  decide +kernel

theorem checked_01010000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_80 = true := by
  decide +kernel

theorem checked_01010001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_81 = true := by
  decide +kernel

theorem checked_01010010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_82 = true := by
  decide +kernel

theorem checked_01010011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_83 = true := by
  decide +kernel

theorem checked_01010100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_84 = true := by
  decide +kernel

theorem checked_01010101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_85 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

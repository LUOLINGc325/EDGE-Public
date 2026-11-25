import PublishedInstanceReplay02

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00001001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_9 = true := by
  decide +kernel

theorem checked_00001010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_10 = true := by
  decide +kernel

theorem checked_00001011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_11 = true := by
  decide +kernel

theorem checked_00001100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_12 = true := by
  decide +kernel

theorem checked_00001101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_13 = true := by
  decide +kernel

theorem checked_00001110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_14 = true := by
  decide +kernel

theorem checked_00001111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_15 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

import PublishedInstanceReplay04

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00010110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_22 = true := by
  decide +kernel

theorem checked_00010111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_23 = true := by
  decide +kernel

theorem checked_00011000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_24 = true := by
  decide +kernel

theorem checked_00011001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_25 = true := by
  decide +kernel

theorem checked_00011010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_26 = true := by
  decide +kernel

theorem checked_00011011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_27 = true := by
  decide +kernel

theorem checked_00011100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_28 = true := by
  decide +kernel

theorem checked_00011101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_29 = true := by
  decide +kernel

theorem checked_00011110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_30 = true := by
  decide +kernel

theorem checked_00011111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_31 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

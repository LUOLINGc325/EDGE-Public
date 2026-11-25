import PublishedInstanceReplay03

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00010000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_16 = true := by
  decide +kernel

theorem checked_00010001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_17 = true := by
  decide +kernel

theorem checked_00010010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_18 = true := by
  decide +kernel

theorem checked_00010011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_19 = true := by
  decide +kernel

theorem checked_00010100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_20 = true := by
  decide +kernel

theorem checked_00010101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_21 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

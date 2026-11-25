import PublishedInstanceReplay05

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00100000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  decide +kernel

theorem checked_00100001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_33 = true := by
  decide +kernel

theorem checked_00100010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_34 = true := by
  decide +kernel

theorem checked_00100011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_35 = true := by
  decide +kernel

theorem checked_00100100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_36 = true := by
  decide +kernel

theorem checked_00100101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_37 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

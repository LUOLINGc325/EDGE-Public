import PublishedInstanceReplay01

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00000100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_4 = true := by
  decide +kernel

theorem checked_00000101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_5 = true := by
  decide +kernel

theorem checked_00000110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_6 = true := by
  decide +kernel

theorem checked_00000111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_7 = true := by
  decide +kernel

theorem checked_00001000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_8 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

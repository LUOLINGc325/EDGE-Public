import PublishedInstanceReplay14

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_10000010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_130 = true := by
  decide +kernel

theorem checked_10000011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_131 = true := by
  decide +kernel

theorem checked_10000100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_132 = true := by
  decide +kernel

theorem checked_10000101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_133 = true := by
  decide +kernel

theorem checked_10000110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_134 = true := by
  decide +kernel

theorem checked_10000111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_135 = true := by
  decide +kernel

theorem checked_10001000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_136 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

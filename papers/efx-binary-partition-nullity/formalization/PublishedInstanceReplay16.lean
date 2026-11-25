import PublishedInstanceReplay15

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_10001001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_137 = true := by
  decide +kernel

theorem checked_10001010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_138 = true := by
  decide +kernel

theorem checked_10001011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_139 = true := by
  decide +kernel

theorem checked_10001100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_140 = true := by
  decide +kernel

theorem checked_10001101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_141 = true := by
  decide +kernel

theorem checked_10001110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_142 = true := by
  decide +kernel

theorem checked_10001111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_143 = true := by
  decide +kernel

theorem checked_10010000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_144 = true := by
  decide +kernel

theorem checked_10010001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_145 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

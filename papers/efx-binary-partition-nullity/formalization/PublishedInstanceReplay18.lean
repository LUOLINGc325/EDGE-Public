import PublishedInstanceReplay17

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_10100000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  decide +kernel

theorem checked_10100001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_161 = true := by
  decide +kernel

theorem checked_10100010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_162 = true := by
  decide +kernel

theorem checked_10100011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_163 = true := by
  decide +kernel

theorem checked_10100100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_164 = true := by
  decide +kernel

theorem checked_10100101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_165 = true := by
  decide +kernel

theorem checked_10100110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_166 = true := by
  decide +kernel

theorem checked_10100111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_167 = true := by
  decide +kernel

theorem checked_10101000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_168 = true := by
  decide +kernel

theorem checked_10101001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_169 = true := by
  decide +kernel

theorem checked_10101010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_170 = true := by
  decide +kernel

theorem checked_10101011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_171 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

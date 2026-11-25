import PublishedInstanceReplay09

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_01000100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_68 = true := by
  decide +kernel

theorem checked_01000101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_69 = true := by
  decide +kernel

theorem checked_01000110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_70 = true := by
  decide +kernel

theorem checked_01000111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_71 = true := by
  decide +kernel

theorem checked_01001000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_72 = true := by
  decide +kernel

theorem checked_01001001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_73 = true := by
  decide +kernel

theorem checked_01001010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_74 = true := by
  decide +kernel

theorem checked_01001011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_75 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

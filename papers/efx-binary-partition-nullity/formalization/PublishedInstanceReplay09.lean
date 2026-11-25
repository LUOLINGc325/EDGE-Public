import PublishedInstanceReplay08

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00111011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_59 = true := by
  decide +kernel

theorem checked_00111100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_60 = true := by
  decide +kernel

theorem checked_00111101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_61 = true := by
  decide +kernel

theorem checked_00111110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_62 = true := by
  decide +kernel

theorem checked_00111111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_63 = true := by
  decide +kernel

theorem checked_01000000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  decide +kernel

theorem checked_01000001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_65 = true := by
  decide +kernel

theorem checked_01000010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_66 = true := by
  decide +kernel

theorem checked_01000011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_67 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

import PublishedInstanceReplay07

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00110000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_48 = true := by
  decide +kernel

theorem checked_00110001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_49 = true := by
  decide +kernel

theorem checked_00110010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_50 = true := by
  decide +kernel

theorem checked_00110011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_51 = true := by
  decide +kernel

theorem checked_00110100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_52 = true := by
  decide +kernel

theorem checked_00110101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_53 = true := by
  decide +kernel

theorem checked_00110110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_54 = true := by
  decide +kernel

theorem checked_00110111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_55 = true := by
  decide +kernel

theorem checked_00111000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_56 = true := by
  decide +kernel

theorem checked_00111001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_57 = true := by
  decide +kernel

theorem checked_00111010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_58 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

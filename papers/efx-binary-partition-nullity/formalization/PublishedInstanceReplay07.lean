import PublishedInstanceReplay06

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00100110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_38 = true := by
  decide +kernel

theorem checked_00100111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_39 = true := by
  decide +kernel

theorem checked_00101000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_40 = true := by
  decide +kernel

theorem checked_00101001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_41 = true := by
  decide +kernel

theorem checked_00101010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_42 = true := by
  decide +kernel

theorem checked_00101011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_43 = true := by
  decide +kernel

theorem checked_00101100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_44 = true := by
  decide +kernel

theorem checked_00101101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_45 = true := by
  decide +kernel

theorem checked_00101110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_46 = true := by
  decide +kernel

theorem checked_00101111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_47 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

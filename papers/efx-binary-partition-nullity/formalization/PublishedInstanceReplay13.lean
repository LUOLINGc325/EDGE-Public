import PublishedInstanceReplay12

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_01100011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_99 = true := by
  decide +kernel

theorem checked_01100100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_100 = true := by
  decide +kernel

theorem checked_01100101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_101 = true := by
  decide +kernel

theorem checked_01100110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_102 = true := by
  decide +kernel

theorem checked_01100111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_103 = true := by
  decide +kernel

theorem checked_01101000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_104 = true := by
  decide +kernel

theorem checked_01101001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_105 = true := by
  decide +kernel

theorem checked_01101010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_106 = true := by
  decide +kernel

theorem checked_01101011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_107 = true := by
  decide +kernel

theorem checked_01101100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_108 = true := by
  decide +kernel

theorem checked_01101101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_109 = true := by
  decide +kernel

theorem checked_01101110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_110 = true := by
  decide +kernel

theorem checked_01101111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_111 = true := by
  decide +kernel

theorem checked_01110000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_112 = true := by
  decide +kernel

theorem checked_01110001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_113 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

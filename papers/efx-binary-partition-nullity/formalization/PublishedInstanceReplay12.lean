import PublishedInstanceReplay11

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_01010110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_86 = true := by
  decide +kernel

theorem checked_01010111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_87 = true := by
  decide +kernel

theorem checked_01011000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_88 = true := by
  decide +kernel

theorem checked_01011001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_89 = true := by
  decide +kernel

theorem checked_01011010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_90 = true := by
  decide +kernel

theorem checked_01011011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_91 = true := by
  decide +kernel

theorem checked_01011100 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_92 = true := by
  decide +kernel

theorem checked_01011101 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_93 = true := by
  decide +kernel

theorem checked_01011110 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_94 = true := by
  decide +kernel

theorem checked_01011111 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_95 = true := by
  decide +kernel

theorem checked_01100000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  decide +kernel

theorem checked_01100001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_97 = true := by
  decide +kernel

theorem checked_01100010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_98 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

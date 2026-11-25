import PublishedInstanceSearchStates

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

theorem checked_00000000 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  decide +kernel

theorem checked_00000001 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_1 = true := by
  decide +kernel

theorem checked_00000010 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_2 = true := by
  decide +kernel

theorem checked_00000011 : checkBounds [8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_3 = true := by
  decide +kernel

end TwoColorNullity.PublishedInstance

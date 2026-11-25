import PublishedInstanceReplay22

namespace TwoColorNullity.PublishedInstance

set_option maxRecDepth 16384
set_option maxHeartbeats 4000000

private theorem checked_0000000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_00000000
  · have refined : refineBuckets 7 [searchedWords] = buckets_1 := by decide +kernel
    rw [refined]
    exact checked_00000001

private theorem checked_0000001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_2 = true := by
  apply checkBounds_from_children
  · exact checked_00000010
  · have refined : refineBuckets 7 buckets_2 = buckets_3 := by decide +kernel
    rw [refined]
    exact checked_00000011

private theorem checked_000000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_0000000
  · have refined : refineBuckets 6 [searchedWords] = buckets_2 := by decide +kernel
    rw [refined]
    exact checked_0000001

private theorem checked_0000010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_4 = true := by
  apply checkBounds_from_children
  · exact checked_00000100
  · have refined : refineBuckets 7 buckets_4 = buckets_5 := by decide +kernel
    rw [refined]
    exact checked_00000101

private theorem checked_0000011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_6 = true := by
  apply checkBounds_from_children
  · exact checked_00000110
  · have refined : refineBuckets 7 buckets_6 = buckets_7 := by decide +kernel
    rw [refined]
    exact checked_00000111

private theorem checked_000001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_4 = true := by
  apply checkBounds_from_children
  · exact checked_0000010
  · have refined : refineBuckets 6 buckets_4 = buckets_6 := by decide +kernel
    rw [refined]
    exact checked_0000011

private theorem checked_00000 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_000000
  · have refined : refineBuckets 5 [searchedWords] = buckets_4 := by decide +kernel
    rw [refined]
    exact checked_000001

private theorem checked_0000100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_8 = true := by
  apply checkBounds_from_children
  · exact checked_00001000
  · have refined : refineBuckets 7 buckets_8 = buckets_9 := by decide +kernel
    rw [refined]
    exact checked_00001001

private theorem checked_0000101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_10 = true := by
  apply checkBounds_from_children
  · exact checked_00001010
  · have refined : refineBuckets 7 buckets_10 = buckets_11 := by decide +kernel
    rw [refined]
    exact checked_00001011

private theorem checked_000010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_8 = true := by
  apply checkBounds_from_children
  · exact checked_0000100
  · have refined : refineBuckets 6 buckets_8 = buckets_10 := by decide +kernel
    rw [refined]
    exact checked_0000101

private theorem checked_0000110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_12 = true := by
  apply checkBounds_from_children
  · exact checked_00001100
  · have refined : refineBuckets 7 buckets_12 = buckets_13 := by decide +kernel
    rw [refined]
    exact checked_00001101

private theorem checked_0000111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_14 = true := by
  apply checkBounds_from_children
  · exact checked_00001110
  · have refined : refineBuckets 7 buckets_14 = buckets_15 := by decide +kernel
    rw [refined]
    exact checked_00001111

private theorem checked_000011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_12 = true := by
  apply checkBounds_from_children
  · exact checked_0000110
  · have refined : refineBuckets 6 buckets_12 = buckets_14 := by decide +kernel
    rw [refined]
    exact checked_0000111

private theorem checked_00001 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_8 = true := by
  apply checkBounds_from_children
  · exact checked_000010
  · have refined : refineBuckets 5 buckets_8 = buckets_12 := by decide +kernel
    rw [refined]
    exact checked_000011

private theorem checked_0000 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_00000
  · have refined : refineBuckets 4 [searchedWords] = buckets_8 := by decide +kernel
    rw [refined]
    exact checked_00001

private theorem checked_0001000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_16 = true := by
  apply checkBounds_from_children
  · exact checked_00010000
  · have refined : refineBuckets 7 buckets_16 = buckets_17 := by decide +kernel
    rw [refined]
    exact checked_00010001

private theorem checked_0001001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_18 = true := by
  apply checkBounds_from_children
  · exact checked_00010010
  · have refined : refineBuckets 7 buckets_18 = buckets_19 := by decide +kernel
    rw [refined]
    exact checked_00010011

private theorem checked_000100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_16 = true := by
  apply checkBounds_from_children
  · exact checked_0001000
  · have refined : refineBuckets 6 buckets_16 = buckets_18 := by decide +kernel
    rw [refined]
    exact checked_0001001

private theorem checked_0001010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_20 = true := by
  apply checkBounds_from_children
  · exact checked_00010100
  · have refined : refineBuckets 7 buckets_20 = buckets_21 := by decide +kernel
    rw [refined]
    exact checked_00010101

private theorem checked_0001011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_22 = true := by
  apply checkBounds_from_children
  · exact checked_00010110
  · have refined : refineBuckets 7 buckets_22 = buckets_23 := by decide +kernel
    rw [refined]
    exact checked_00010111

private theorem checked_000101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_20 = true := by
  apply checkBounds_from_children
  · exact checked_0001010
  · have refined : refineBuckets 6 buckets_20 = buckets_22 := by decide +kernel
    rw [refined]
    exact checked_0001011

private theorem checked_00010 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_16 = true := by
  apply checkBounds_from_children
  · exact checked_000100
  · have refined : refineBuckets 5 buckets_16 = buckets_20 := by decide +kernel
    rw [refined]
    exact checked_000101

private theorem checked_0001100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_24 = true := by
  apply checkBounds_from_children
  · exact checked_00011000
  · have refined : refineBuckets 7 buckets_24 = buckets_25 := by decide +kernel
    rw [refined]
    exact checked_00011001

private theorem checked_0001101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_26 = true := by
  apply checkBounds_from_children
  · exact checked_00011010
  · have refined : refineBuckets 7 buckets_26 = buckets_27 := by decide +kernel
    rw [refined]
    exact checked_00011011

private theorem checked_000110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_24 = true := by
  apply checkBounds_from_children
  · exact checked_0001100
  · have refined : refineBuckets 6 buckets_24 = buckets_26 := by decide +kernel
    rw [refined]
    exact checked_0001101

private theorem checked_0001110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_28 = true := by
  apply checkBounds_from_children
  · exact checked_00011100
  · have refined : refineBuckets 7 buckets_28 = buckets_29 := by decide +kernel
    rw [refined]
    exact checked_00011101

private theorem checked_0001111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_30 = true := by
  apply checkBounds_from_children
  · exact checked_00011110
  · have refined : refineBuckets 7 buckets_30 = buckets_31 := by decide +kernel
    rw [refined]
    exact checked_00011111

private theorem checked_000111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_28 = true := by
  apply checkBounds_from_children
  · exact checked_0001110
  · have refined : refineBuckets 6 buckets_28 = buckets_30 := by decide +kernel
    rw [refined]
    exact checked_0001111

private theorem checked_00011 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_24 = true := by
  apply checkBounds_from_children
  · exact checked_000110
  · have refined : refineBuckets 5 buckets_24 = buckets_28 := by decide +kernel
    rw [refined]
    exact checked_000111

private theorem checked_0001 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_16 = true := by
  apply checkBounds_from_children
  · exact checked_00010
  · have refined : refineBuckets 4 buckets_16 = buckets_24 := by decide +kernel
    rw [refined]
    exact checked_00011

private theorem checked_000 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_0000
  · have refined : refineBuckets 3 [searchedWords] = buckets_16 := by decide +kernel
    rw [refined]
    exact checked_0001

private theorem checked_0010000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  apply checkBounds_from_children
  · exact checked_00100000
  · have refined : refineBuckets 7 buckets_32 = buckets_33 := by decide +kernel
    rw [refined]
    exact checked_00100001

private theorem checked_0010001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_34 = true := by
  apply checkBounds_from_children
  · exact checked_00100010
  · have refined : refineBuckets 7 buckets_34 = buckets_35 := by decide +kernel
    rw [refined]
    exact checked_00100011

private theorem checked_001000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  apply checkBounds_from_children
  · exact checked_0010000
  · have refined : refineBuckets 6 buckets_32 = buckets_34 := by decide +kernel
    rw [refined]
    exact checked_0010001

private theorem checked_0010010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_36 = true := by
  apply checkBounds_from_children
  · exact checked_00100100
  · have refined : refineBuckets 7 buckets_36 = buckets_37 := by decide +kernel
    rw [refined]
    exact checked_00100101

private theorem checked_0010011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_38 = true := by
  apply checkBounds_from_children
  · exact checked_00100110
  · have refined : refineBuckets 7 buckets_38 = buckets_39 := by decide +kernel
    rw [refined]
    exact checked_00100111

private theorem checked_001001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_36 = true := by
  apply checkBounds_from_children
  · exact checked_0010010
  · have refined : refineBuckets 6 buckets_36 = buckets_38 := by decide +kernel
    rw [refined]
    exact checked_0010011

private theorem checked_00100 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  apply checkBounds_from_children
  · exact checked_001000
  · have refined : refineBuckets 5 buckets_32 = buckets_36 := by decide +kernel
    rw [refined]
    exact checked_001001

private theorem checked_0010100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_40 = true := by
  apply checkBounds_from_children
  · exact checked_00101000
  · have refined : refineBuckets 7 buckets_40 = buckets_41 := by decide +kernel
    rw [refined]
    exact checked_00101001

private theorem checked_0010101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_42 = true := by
  apply checkBounds_from_children
  · exact checked_00101010
  · have refined : refineBuckets 7 buckets_42 = buckets_43 := by decide +kernel
    rw [refined]
    exact checked_00101011

private theorem checked_001010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_40 = true := by
  apply checkBounds_from_children
  · exact checked_0010100
  · have refined : refineBuckets 6 buckets_40 = buckets_42 := by decide +kernel
    rw [refined]
    exact checked_0010101

private theorem checked_0010110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_44 = true := by
  apply checkBounds_from_children
  · exact checked_00101100
  · have refined : refineBuckets 7 buckets_44 = buckets_45 := by decide +kernel
    rw [refined]
    exact checked_00101101

private theorem checked_0010111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_46 = true := by
  apply checkBounds_from_children
  · exact checked_00101110
  · have refined : refineBuckets 7 buckets_46 = buckets_47 := by decide +kernel
    rw [refined]
    exact checked_00101111

private theorem checked_001011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_44 = true := by
  apply checkBounds_from_children
  · exact checked_0010110
  · have refined : refineBuckets 6 buckets_44 = buckets_46 := by decide +kernel
    rw [refined]
    exact checked_0010111

private theorem checked_00101 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_40 = true := by
  apply checkBounds_from_children
  · exact checked_001010
  · have refined : refineBuckets 5 buckets_40 = buckets_44 := by decide +kernel
    rw [refined]
    exact checked_001011

private theorem checked_0010 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  apply checkBounds_from_children
  · exact checked_00100
  · have refined : refineBuckets 4 buckets_32 = buckets_40 := by decide +kernel
    rw [refined]
    exact checked_00101

private theorem checked_0011000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_48 = true := by
  apply checkBounds_from_children
  · exact checked_00110000
  · have refined : refineBuckets 7 buckets_48 = buckets_49 := by decide +kernel
    rw [refined]
    exact checked_00110001

private theorem checked_0011001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_50 = true := by
  apply checkBounds_from_children
  · exact checked_00110010
  · have refined : refineBuckets 7 buckets_50 = buckets_51 := by decide +kernel
    rw [refined]
    exact checked_00110011

private theorem checked_001100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_48 = true := by
  apply checkBounds_from_children
  · exact checked_0011000
  · have refined : refineBuckets 6 buckets_48 = buckets_50 := by decide +kernel
    rw [refined]
    exact checked_0011001

private theorem checked_0011010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_52 = true := by
  apply checkBounds_from_children
  · exact checked_00110100
  · have refined : refineBuckets 7 buckets_52 = buckets_53 := by decide +kernel
    rw [refined]
    exact checked_00110101

private theorem checked_0011011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_54 = true := by
  apply checkBounds_from_children
  · exact checked_00110110
  · have refined : refineBuckets 7 buckets_54 = buckets_55 := by decide +kernel
    rw [refined]
    exact checked_00110111

private theorem checked_001101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_52 = true := by
  apply checkBounds_from_children
  · exact checked_0011010
  · have refined : refineBuckets 6 buckets_52 = buckets_54 := by decide +kernel
    rw [refined]
    exact checked_0011011

private theorem checked_00110 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_48 = true := by
  apply checkBounds_from_children
  · exact checked_001100
  · have refined : refineBuckets 5 buckets_48 = buckets_52 := by decide +kernel
    rw [refined]
    exact checked_001101

private theorem checked_0011100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_56 = true := by
  apply checkBounds_from_children
  · exact checked_00111000
  · have refined : refineBuckets 7 buckets_56 = buckets_57 := by decide +kernel
    rw [refined]
    exact checked_00111001

private theorem checked_0011101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_58 = true := by
  apply checkBounds_from_children
  · exact checked_00111010
  · have refined : refineBuckets 7 buckets_58 = buckets_59 := by decide +kernel
    rw [refined]
    exact checked_00111011

private theorem checked_001110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_56 = true := by
  apply checkBounds_from_children
  · exact checked_0011100
  · have refined : refineBuckets 6 buckets_56 = buckets_58 := by decide +kernel
    rw [refined]
    exact checked_0011101

private theorem checked_0011110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_60 = true := by
  apply checkBounds_from_children
  · exact checked_00111100
  · have refined : refineBuckets 7 buckets_60 = buckets_61 := by decide +kernel
    rw [refined]
    exact checked_00111101

private theorem checked_0011111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_62 = true := by
  apply checkBounds_from_children
  · exact checked_00111110
  · have refined : refineBuckets 7 buckets_62 = buckets_63 := by decide +kernel
    rw [refined]
    exact checked_00111111

private theorem checked_001111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_60 = true := by
  apply checkBounds_from_children
  · exact checked_0011110
  · have refined : refineBuckets 6 buckets_60 = buckets_62 := by decide +kernel
    rw [refined]
    exact checked_0011111

private theorem checked_00111 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_56 = true := by
  apply checkBounds_from_children
  · exact checked_001110
  · have refined : refineBuckets 5 buckets_56 = buckets_60 := by decide +kernel
    rw [refined]
    exact checked_001111

private theorem checked_0011 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_48 = true := by
  apply checkBounds_from_children
  · exact checked_00110
  · have refined : refineBuckets 4 buckets_48 = buckets_56 := by decide +kernel
    rw [refined]
    exact checked_00111

private theorem checked_001 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_32 = true := by
  apply checkBounds_from_children
  · exact checked_0010
  · have refined : refineBuckets 3 buckets_32 = buckets_48 := by decide +kernel
    rw [refined]
    exact checked_0011

private theorem checked_00 : checkBounds [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_000
  · have refined : refineBuckets 2 [searchedWords] = buckets_32 := by decide +kernel
    rw [refined]
    exact checked_001

private theorem checked_0100000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_01000000
  · have refined : refineBuckets 7 buckets_64 = buckets_65 := by decide +kernel
    rw [refined]
    exact checked_01000001

private theorem checked_0100001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_66 = true := by
  apply checkBounds_from_children
  · exact checked_01000010
  · have refined : refineBuckets 7 buckets_66 = buckets_67 := by decide +kernel
    rw [refined]
    exact checked_01000011

private theorem checked_010000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_0100000
  · have refined : refineBuckets 6 buckets_64 = buckets_66 := by decide +kernel
    rw [refined]
    exact checked_0100001

private theorem checked_0100010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_68 = true := by
  apply checkBounds_from_children
  · exact checked_01000100
  · have refined : refineBuckets 7 buckets_68 = buckets_69 := by decide +kernel
    rw [refined]
    exact checked_01000101

private theorem checked_0100011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_70 = true := by
  apply checkBounds_from_children
  · exact checked_01000110
  · have refined : refineBuckets 7 buckets_70 = buckets_71 := by decide +kernel
    rw [refined]
    exact checked_01000111

private theorem checked_010001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_68 = true := by
  apply checkBounds_from_children
  · exact checked_0100010
  · have refined : refineBuckets 6 buckets_68 = buckets_70 := by decide +kernel
    rw [refined]
    exact checked_0100011

private theorem checked_01000 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_010000
  · have refined : refineBuckets 5 buckets_64 = buckets_68 := by decide +kernel
    rw [refined]
    exact checked_010001

private theorem checked_0100100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_72 = true := by
  apply checkBounds_from_children
  · exact checked_01001000
  · have refined : refineBuckets 7 buckets_72 = buckets_73 := by decide +kernel
    rw [refined]
    exact checked_01001001

private theorem checked_0100101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_74 = true := by
  apply checkBounds_from_children
  · exact checked_01001010
  · have refined : refineBuckets 7 buckets_74 = buckets_75 := by decide +kernel
    rw [refined]
    exact checked_01001011

private theorem checked_010010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_72 = true := by
  apply checkBounds_from_children
  · exact checked_0100100
  · have refined : refineBuckets 6 buckets_72 = buckets_74 := by decide +kernel
    rw [refined]
    exact checked_0100101

private theorem checked_0100110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_76 = true := by
  apply checkBounds_from_children
  · exact checked_01001100
  · have refined : refineBuckets 7 buckets_76 = buckets_77 := by decide +kernel
    rw [refined]
    exact checked_01001101

private theorem checked_0100111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_78 = true := by
  apply checkBounds_from_children
  · exact checked_01001110
  · have refined : refineBuckets 7 buckets_78 = buckets_79 := by decide +kernel
    rw [refined]
    exact checked_01001111

private theorem checked_010011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_76 = true := by
  apply checkBounds_from_children
  · exact checked_0100110
  · have refined : refineBuckets 6 buckets_76 = buckets_78 := by decide +kernel
    rw [refined]
    exact checked_0100111

private theorem checked_01001 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_72 = true := by
  apply checkBounds_from_children
  · exact checked_010010
  · have refined : refineBuckets 5 buckets_72 = buckets_76 := by decide +kernel
    rw [refined]
    exact checked_010011

private theorem checked_0100 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_01000
  · have refined : refineBuckets 4 buckets_64 = buckets_72 := by decide +kernel
    rw [refined]
    exact checked_01001

private theorem checked_0101000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_80 = true := by
  apply checkBounds_from_children
  · exact checked_01010000
  · have refined : refineBuckets 7 buckets_80 = buckets_81 := by decide +kernel
    rw [refined]
    exact checked_01010001

private theorem checked_0101001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_82 = true := by
  apply checkBounds_from_children
  · exact checked_01010010
  · have refined : refineBuckets 7 buckets_82 = buckets_83 := by decide +kernel
    rw [refined]
    exact checked_01010011

private theorem checked_010100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_80 = true := by
  apply checkBounds_from_children
  · exact checked_0101000
  · have refined : refineBuckets 6 buckets_80 = buckets_82 := by decide +kernel
    rw [refined]
    exact checked_0101001

private theorem checked_0101010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_84 = true := by
  apply checkBounds_from_children
  · exact checked_01010100
  · have refined : refineBuckets 7 buckets_84 = buckets_85 := by decide +kernel
    rw [refined]
    exact checked_01010101

private theorem checked_0101011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_86 = true := by
  apply checkBounds_from_children
  · exact checked_01010110
  · have refined : refineBuckets 7 buckets_86 = buckets_87 := by decide +kernel
    rw [refined]
    exact checked_01010111

private theorem checked_010101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_84 = true := by
  apply checkBounds_from_children
  · exact checked_0101010
  · have refined : refineBuckets 6 buckets_84 = buckets_86 := by decide +kernel
    rw [refined]
    exact checked_0101011

private theorem checked_01010 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_80 = true := by
  apply checkBounds_from_children
  · exact checked_010100
  · have refined : refineBuckets 5 buckets_80 = buckets_84 := by decide +kernel
    rw [refined]
    exact checked_010101

private theorem checked_0101100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_88 = true := by
  apply checkBounds_from_children
  · exact checked_01011000
  · have refined : refineBuckets 7 buckets_88 = buckets_89 := by decide +kernel
    rw [refined]
    exact checked_01011001

private theorem checked_0101101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_90 = true := by
  apply checkBounds_from_children
  · exact checked_01011010
  · have refined : refineBuckets 7 buckets_90 = buckets_91 := by decide +kernel
    rw [refined]
    exact checked_01011011

private theorem checked_010110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_88 = true := by
  apply checkBounds_from_children
  · exact checked_0101100
  · have refined : refineBuckets 6 buckets_88 = buckets_90 := by decide +kernel
    rw [refined]
    exact checked_0101101

private theorem checked_0101110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_92 = true := by
  apply checkBounds_from_children
  · exact checked_01011100
  · have refined : refineBuckets 7 buckets_92 = buckets_93 := by decide +kernel
    rw [refined]
    exact checked_01011101

private theorem checked_0101111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_94 = true := by
  apply checkBounds_from_children
  · exact checked_01011110
  · have refined : refineBuckets 7 buckets_94 = buckets_95 := by decide +kernel
    rw [refined]
    exact checked_01011111

private theorem checked_010111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_92 = true := by
  apply checkBounds_from_children
  · exact checked_0101110
  · have refined : refineBuckets 6 buckets_92 = buckets_94 := by decide +kernel
    rw [refined]
    exact checked_0101111

private theorem checked_01011 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_88 = true := by
  apply checkBounds_from_children
  · exact checked_010110
  · have refined : refineBuckets 5 buckets_88 = buckets_92 := by decide +kernel
    rw [refined]
    exact checked_010111

private theorem checked_0101 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_80 = true := by
  apply checkBounds_from_children
  · exact checked_01010
  · have refined : refineBuckets 4 buckets_80 = buckets_88 := by decide +kernel
    rw [refined]
    exact checked_01011

private theorem checked_010 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_0100
  · have refined : refineBuckets 3 buckets_64 = buckets_80 := by decide +kernel
    rw [refined]
    exact checked_0101

private theorem checked_0110000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  apply checkBounds_from_children
  · exact checked_01100000
  · have refined : refineBuckets 7 buckets_96 = buckets_97 := by decide +kernel
    rw [refined]
    exact checked_01100001

private theorem checked_0110001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_98 = true := by
  apply checkBounds_from_children
  · exact checked_01100010
  · have refined : refineBuckets 7 buckets_98 = buckets_99 := by decide +kernel
    rw [refined]
    exact checked_01100011

private theorem checked_011000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  apply checkBounds_from_children
  · exact checked_0110000
  · have refined : refineBuckets 6 buckets_96 = buckets_98 := by decide +kernel
    rw [refined]
    exact checked_0110001

private theorem checked_0110010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_100 = true := by
  apply checkBounds_from_children
  · exact checked_01100100
  · have refined : refineBuckets 7 buckets_100 = buckets_101 := by decide +kernel
    rw [refined]
    exact checked_01100101

private theorem checked_0110011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_102 = true := by
  apply checkBounds_from_children
  · exact checked_01100110
  · have refined : refineBuckets 7 buckets_102 = buckets_103 := by decide +kernel
    rw [refined]
    exact checked_01100111

private theorem checked_011001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_100 = true := by
  apply checkBounds_from_children
  · exact checked_0110010
  · have refined : refineBuckets 6 buckets_100 = buckets_102 := by decide +kernel
    rw [refined]
    exact checked_0110011

private theorem checked_01100 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  apply checkBounds_from_children
  · exact checked_011000
  · have refined : refineBuckets 5 buckets_96 = buckets_100 := by decide +kernel
    rw [refined]
    exact checked_011001

private theorem checked_0110100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_104 = true := by
  apply checkBounds_from_children
  · exact checked_01101000
  · have refined : refineBuckets 7 buckets_104 = buckets_105 := by decide +kernel
    rw [refined]
    exact checked_01101001

private theorem checked_0110101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_106 = true := by
  apply checkBounds_from_children
  · exact checked_01101010
  · have refined : refineBuckets 7 buckets_106 = buckets_107 := by decide +kernel
    rw [refined]
    exact checked_01101011

private theorem checked_011010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_104 = true := by
  apply checkBounds_from_children
  · exact checked_0110100
  · have refined : refineBuckets 6 buckets_104 = buckets_106 := by decide +kernel
    rw [refined]
    exact checked_0110101

private theorem checked_0110110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_108 = true := by
  apply checkBounds_from_children
  · exact checked_01101100
  · have refined : refineBuckets 7 buckets_108 = buckets_109 := by decide +kernel
    rw [refined]
    exact checked_01101101

private theorem checked_0110111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_110 = true := by
  apply checkBounds_from_children
  · exact checked_01101110
  · have refined : refineBuckets 7 buckets_110 = buckets_111 := by decide +kernel
    rw [refined]
    exact checked_01101111

private theorem checked_011011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_108 = true := by
  apply checkBounds_from_children
  · exact checked_0110110
  · have refined : refineBuckets 6 buckets_108 = buckets_110 := by decide +kernel
    rw [refined]
    exact checked_0110111

private theorem checked_01101 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_104 = true := by
  apply checkBounds_from_children
  · exact checked_011010
  · have refined : refineBuckets 5 buckets_104 = buckets_108 := by decide +kernel
    rw [refined]
    exact checked_011011

private theorem checked_0110 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  apply checkBounds_from_children
  · exact checked_01100
  · have refined : refineBuckets 4 buckets_96 = buckets_104 := by decide +kernel
    rw [refined]
    exact checked_01101

private theorem checked_0111000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_112 = true := by
  apply checkBounds_from_children
  · exact checked_01110000
  · have refined : refineBuckets 7 buckets_112 = buckets_113 := by decide +kernel
    rw [refined]
    exact checked_01110001

private theorem checked_0111001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_114 = true := by
  apply checkBounds_from_children
  · exact checked_01110010
  · have refined : refineBuckets 7 buckets_114 = buckets_115 := by decide +kernel
    rw [refined]
    exact checked_01110011

private theorem checked_011100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_112 = true := by
  apply checkBounds_from_children
  · exact checked_0111000
  · have refined : refineBuckets 6 buckets_112 = buckets_114 := by decide +kernel
    rw [refined]
    exact checked_0111001

private theorem checked_0111010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_116 = true := by
  apply checkBounds_from_children
  · exact checked_01110100
  · have refined : refineBuckets 7 buckets_116 = buckets_117 := by decide +kernel
    rw [refined]
    exact checked_01110101

private theorem checked_0111011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_118 = true := by
  apply checkBounds_from_children
  · exact checked_01110110
  · have refined : refineBuckets 7 buckets_118 = buckets_119 := by decide +kernel
    rw [refined]
    exact checked_01110111

private theorem checked_011101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_116 = true := by
  apply checkBounds_from_children
  · exact checked_0111010
  · have refined : refineBuckets 6 buckets_116 = buckets_118 := by decide +kernel
    rw [refined]
    exact checked_0111011

private theorem checked_01110 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_112 = true := by
  apply checkBounds_from_children
  · exact checked_011100
  · have refined : refineBuckets 5 buckets_112 = buckets_116 := by decide +kernel
    rw [refined]
    exact checked_011101

private theorem checked_0111100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_120 = true := by
  apply checkBounds_from_children
  · exact checked_01111000
  · have refined : refineBuckets 7 buckets_120 = buckets_121 := by decide +kernel
    rw [refined]
    exact checked_01111001

private theorem checked_0111101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_122 = true := by
  apply checkBounds_from_children
  · exact checked_01111010
  · have refined : refineBuckets 7 buckets_122 = buckets_123 := by decide +kernel
    rw [refined]
    exact checked_01111011

private theorem checked_011110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_120 = true := by
  apply checkBounds_from_children
  · exact checked_0111100
  · have refined : refineBuckets 6 buckets_120 = buckets_122 := by decide +kernel
    rw [refined]
    exact checked_0111101

private theorem checked_0111110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_124 = true := by
  apply checkBounds_from_children
  · exact checked_01111100
  · have refined : refineBuckets 7 buckets_124 = buckets_125 := by decide +kernel
    rw [refined]
    exact checked_01111101

private theorem checked_0111111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_126 = true := by
  apply checkBounds_from_children
  · exact checked_01111110
  · have refined : refineBuckets 7 buckets_126 = buckets_127 := by decide +kernel
    rw [refined]
    exact checked_01111111

private theorem checked_011111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_124 = true := by
  apply checkBounds_from_children
  · exact checked_0111110
  · have refined : refineBuckets 6 buckets_124 = buckets_126 := by decide +kernel
    rw [refined]
    exact checked_0111111

private theorem checked_01111 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_120 = true := by
  apply checkBounds_from_children
  · exact checked_011110
  · have refined : refineBuckets 5 buckets_120 = buckets_124 := by decide +kernel
    rw [refined]
    exact checked_011111

private theorem checked_0111 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_112 = true := by
  apply checkBounds_from_children
  · exact checked_01110
  · have refined : refineBuckets 4 buckets_112 = buckets_120 := by decide +kernel
    rw [refined]
    exact checked_01111

private theorem checked_011 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_96 = true := by
  apply checkBounds_from_children
  · exact checked_0110
  · have refined : refineBuckets 3 buckets_96 = buckets_112 := by decide +kernel
    rw [refined]
    exact checked_0111

private theorem checked_01 : checkBounds [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_64 = true := by
  apply checkBounds_from_children
  · exact checked_010
  · have refined : refineBuckets 2 buckets_64 = buckets_96 := by decide +kernel
    rw [refined]
    exact checked_011

private theorem checked_0 : checkBounds [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_00
  · have refined : refineBuckets 1 [searchedWords] = buckets_64 := by decide +kernel
    rw [refined]
    exact checked_01

private theorem checked_1000000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_10000000
  · have refined : refineBuckets 7 buckets_128 = buckets_129 := by decide +kernel
    rw [refined]
    exact checked_10000001

private theorem checked_1000001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_130 = true := by
  apply checkBounds_from_children
  · exact checked_10000010
  · have refined : refineBuckets 7 buckets_130 = buckets_131 := by decide +kernel
    rw [refined]
    exact checked_10000011

private theorem checked_100000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_1000000
  · have refined : refineBuckets 6 buckets_128 = buckets_130 := by decide +kernel
    rw [refined]
    exact checked_1000001

private theorem checked_1000010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_132 = true := by
  apply checkBounds_from_children
  · exact checked_10000100
  · have refined : refineBuckets 7 buckets_132 = buckets_133 := by decide +kernel
    rw [refined]
    exact checked_10000101

private theorem checked_1000011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_134 = true := by
  apply checkBounds_from_children
  · exact checked_10000110
  · have refined : refineBuckets 7 buckets_134 = buckets_135 := by decide +kernel
    rw [refined]
    exact checked_10000111

private theorem checked_100001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_132 = true := by
  apply checkBounds_from_children
  · exact checked_1000010
  · have refined : refineBuckets 6 buckets_132 = buckets_134 := by decide +kernel
    rw [refined]
    exact checked_1000011

private theorem checked_10000 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_100000
  · have refined : refineBuckets 5 buckets_128 = buckets_132 := by decide +kernel
    rw [refined]
    exact checked_100001

private theorem checked_1000100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_136 = true := by
  apply checkBounds_from_children
  · exact checked_10001000
  · have refined : refineBuckets 7 buckets_136 = buckets_137 := by decide +kernel
    rw [refined]
    exact checked_10001001

private theorem checked_1000101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_138 = true := by
  apply checkBounds_from_children
  · exact checked_10001010
  · have refined : refineBuckets 7 buckets_138 = buckets_139 := by decide +kernel
    rw [refined]
    exact checked_10001011

private theorem checked_100010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_136 = true := by
  apply checkBounds_from_children
  · exact checked_1000100
  · have refined : refineBuckets 6 buckets_136 = buckets_138 := by decide +kernel
    rw [refined]
    exact checked_1000101

private theorem checked_1000110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_140 = true := by
  apply checkBounds_from_children
  · exact checked_10001100
  · have refined : refineBuckets 7 buckets_140 = buckets_141 := by decide +kernel
    rw [refined]
    exact checked_10001101

private theorem checked_1000111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_142 = true := by
  apply checkBounds_from_children
  · exact checked_10001110
  · have refined : refineBuckets 7 buckets_142 = buckets_143 := by decide +kernel
    rw [refined]
    exact checked_10001111

private theorem checked_100011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_140 = true := by
  apply checkBounds_from_children
  · exact checked_1000110
  · have refined : refineBuckets 6 buckets_140 = buckets_142 := by decide +kernel
    rw [refined]
    exact checked_1000111

private theorem checked_10001 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_136 = true := by
  apply checkBounds_from_children
  · exact checked_100010
  · have refined : refineBuckets 5 buckets_136 = buckets_140 := by decide +kernel
    rw [refined]
    exact checked_100011

private theorem checked_1000 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_10000
  · have refined : refineBuckets 4 buckets_128 = buckets_136 := by decide +kernel
    rw [refined]
    exact checked_10001

private theorem checked_1001000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_144 = true := by
  apply checkBounds_from_children
  · exact checked_10010000
  · have refined : refineBuckets 7 buckets_144 = buckets_145 := by decide +kernel
    rw [refined]
    exact checked_10010001

private theorem checked_1001001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_146 = true := by
  apply checkBounds_from_children
  · exact checked_10010010
  · have refined : refineBuckets 7 buckets_146 = buckets_147 := by decide +kernel
    rw [refined]
    exact checked_10010011

private theorem checked_100100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_144 = true := by
  apply checkBounds_from_children
  · exact checked_1001000
  · have refined : refineBuckets 6 buckets_144 = buckets_146 := by decide +kernel
    rw [refined]
    exact checked_1001001

private theorem checked_1001010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_148 = true := by
  apply checkBounds_from_children
  · exact checked_10010100
  · have refined : refineBuckets 7 buckets_148 = buckets_149 := by decide +kernel
    rw [refined]
    exact checked_10010101

private theorem checked_1001011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_150 = true := by
  apply checkBounds_from_children
  · exact checked_10010110
  · have refined : refineBuckets 7 buckets_150 = buckets_151 := by decide +kernel
    rw [refined]
    exact checked_10010111

private theorem checked_100101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_148 = true := by
  apply checkBounds_from_children
  · exact checked_1001010
  · have refined : refineBuckets 6 buckets_148 = buckets_150 := by decide +kernel
    rw [refined]
    exact checked_1001011

private theorem checked_10010 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_144 = true := by
  apply checkBounds_from_children
  · exact checked_100100
  · have refined : refineBuckets 5 buckets_144 = buckets_148 := by decide +kernel
    rw [refined]
    exact checked_100101

private theorem checked_1001100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_152 = true := by
  apply checkBounds_from_children
  · exact checked_10011000
  · have refined : refineBuckets 7 buckets_152 = buckets_153 := by decide +kernel
    rw [refined]
    exact checked_10011001

private theorem checked_1001101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_154 = true := by
  apply checkBounds_from_children
  · exact checked_10011010
  · have refined : refineBuckets 7 buckets_154 = buckets_155 := by decide +kernel
    rw [refined]
    exact checked_10011011

private theorem checked_100110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_152 = true := by
  apply checkBounds_from_children
  · exact checked_1001100
  · have refined : refineBuckets 6 buckets_152 = buckets_154 := by decide +kernel
    rw [refined]
    exact checked_1001101

private theorem checked_1001110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_156 = true := by
  apply checkBounds_from_children
  · exact checked_10011100
  · have refined : refineBuckets 7 buckets_156 = buckets_157 := by decide +kernel
    rw [refined]
    exact checked_10011101

private theorem checked_1001111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_158 = true := by
  apply checkBounds_from_children
  · exact checked_10011110
  · have refined : refineBuckets 7 buckets_158 = buckets_159 := by decide +kernel
    rw [refined]
    exact checked_10011111

private theorem checked_100111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_156 = true := by
  apply checkBounds_from_children
  · exact checked_1001110
  · have refined : refineBuckets 6 buckets_156 = buckets_158 := by decide +kernel
    rw [refined]
    exact checked_1001111

private theorem checked_10011 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_152 = true := by
  apply checkBounds_from_children
  · exact checked_100110
  · have refined : refineBuckets 5 buckets_152 = buckets_156 := by decide +kernel
    rw [refined]
    exact checked_100111

private theorem checked_1001 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_144 = true := by
  apply checkBounds_from_children
  · exact checked_10010
  · have refined : refineBuckets 4 buckets_144 = buckets_152 := by decide +kernel
    rw [refined]
    exact checked_10011

private theorem checked_100 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_1000
  · have refined : refineBuckets 3 buckets_128 = buckets_144 := by decide +kernel
    rw [refined]
    exact checked_1001

private theorem checked_1010000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  apply checkBounds_from_children
  · exact checked_10100000
  · have refined : refineBuckets 7 buckets_160 = buckets_161 := by decide +kernel
    rw [refined]
    exact checked_10100001

private theorem checked_1010001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_162 = true := by
  apply checkBounds_from_children
  · exact checked_10100010
  · have refined : refineBuckets 7 buckets_162 = buckets_163 := by decide +kernel
    rw [refined]
    exact checked_10100011

private theorem checked_101000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  apply checkBounds_from_children
  · exact checked_1010000
  · have refined : refineBuckets 6 buckets_160 = buckets_162 := by decide +kernel
    rw [refined]
    exact checked_1010001

private theorem checked_1010010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_164 = true := by
  apply checkBounds_from_children
  · exact checked_10100100
  · have refined : refineBuckets 7 buckets_164 = buckets_165 := by decide +kernel
    rw [refined]
    exact checked_10100101

private theorem checked_1010011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_166 = true := by
  apply checkBounds_from_children
  · exact checked_10100110
  · have refined : refineBuckets 7 buckets_166 = buckets_167 := by decide +kernel
    rw [refined]
    exact checked_10100111

private theorem checked_101001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_164 = true := by
  apply checkBounds_from_children
  · exact checked_1010010
  · have refined : refineBuckets 6 buckets_164 = buckets_166 := by decide +kernel
    rw [refined]
    exact checked_1010011

private theorem checked_10100 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  apply checkBounds_from_children
  · exact checked_101000
  · have refined : refineBuckets 5 buckets_160 = buckets_164 := by decide +kernel
    rw [refined]
    exact checked_101001

private theorem checked_1010100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_168 = true := by
  apply checkBounds_from_children
  · exact checked_10101000
  · have refined : refineBuckets 7 buckets_168 = buckets_169 := by decide +kernel
    rw [refined]
    exact checked_10101001

private theorem checked_1010101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_170 = true := by
  apply checkBounds_from_children
  · exact checked_10101010
  · have refined : refineBuckets 7 buckets_170 = buckets_171 := by decide +kernel
    rw [refined]
    exact checked_10101011

private theorem checked_101010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_168 = true := by
  apply checkBounds_from_children
  · exact checked_1010100
  · have refined : refineBuckets 6 buckets_168 = buckets_170 := by decide +kernel
    rw [refined]
    exact checked_1010101

private theorem checked_1010110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_172 = true := by
  apply checkBounds_from_children
  · exact checked_10101100
  · have refined : refineBuckets 7 buckets_172 = buckets_173 := by decide +kernel
    rw [refined]
    exact checked_10101101

private theorem checked_1010111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_174 = true := by
  apply checkBounds_from_children
  · exact checked_10101110
  · have refined : refineBuckets 7 buckets_174 = buckets_175 := by decide +kernel
    rw [refined]
    exact checked_10101111

private theorem checked_101011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_172 = true := by
  apply checkBounds_from_children
  · exact checked_1010110
  · have refined : refineBuckets 6 buckets_172 = buckets_174 := by decide +kernel
    rw [refined]
    exact checked_1010111

private theorem checked_10101 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_168 = true := by
  apply checkBounds_from_children
  · exact checked_101010
  · have refined : refineBuckets 5 buckets_168 = buckets_172 := by decide +kernel
    rw [refined]
    exact checked_101011

private theorem checked_1010 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  apply checkBounds_from_children
  · exact checked_10100
  · have refined : refineBuckets 4 buckets_160 = buckets_168 := by decide +kernel
    rw [refined]
    exact checked_10101

private theorem checked_1011000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_176 = true := by
  apply checkBounds_from_children
  · exact checked_10110000
  · have refined : refineBuckets 7 buckets_176 = buckets_177 := by decide +kernel
    rw [refined]
    exact checked_10110001

private theorem checked_1011001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_178 = true := by
  apply checkBounds_from_children
  · exact checked_10110010
  · have refined : refineBuckets 7 buckets_178 = buckets_179 := by decide +kernel
    rw [refined]
    exact checked_10110011

private theorem checked_101100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_176 = true := by
  apply checkBounds_from_children
  · exact checked_1011000
  · have refined : refineBuckets 6 buckets_176 = buckets_178 := by decide +kernel
    rw [refined]
    exact checked_1011001

private theorem checked_1011010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_180 = true := by
  apply checkBounds_from_children
  · exact checked_10110100
  · have refined : refineBuckets 7 buckets_180 = buckets_181 := by decide +kernel
    rw [refined]
    exact checked_10110101

private theorem checked_1011011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_182 = true := by
  apply checkBounds_from_children
  · exact checked_10110110
  · have refined : refineBuckets 7 buckets_182 = buckets_183 := by decide +kernel
    rw [refined]
    exact checked_10110111

private theorem checked_101101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_180 = true := by
  apply checkBounds_from_children
  · exact checked_1011010
  · have refined : refineBuckets 6 buckets_180 = buckets_182 := by decide +kernel
    rw [refined]
    exact checked_1011011

private theorem checked_10110 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_176 = true := by
  apply checkBounds_from_children
  · exact checked_101100
  · have refined : refineBuckets 5 buckets_176 = buckets_180 := by decide +kernel
    rw [refined]
    exact checked_101101

private theorem checked_1011100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_184 = true := by
  apply checkBounds_from_children
  · exact checked_10111000
  · have refined : refineBuckets 7 buckets_184 = buckets_185 := by decide +kernel
    rw [refined]
    exact checked_10111001

private theorem checked_1011101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_186 = true := by
  apply checkBounds_from_children
  · exact checked_10111010
  · have refined : refineBuckets 7 buckets_186 = buckets_187 := by decide +kernel
    rw [refined]
    exact checked_10111011

private theorem checked_101110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_184 = true := by
  apply checkBounds_from_children
  · exact checked_1011100
  · have refined : refineBuckets 6 buckets_184 = buckets_186 := by decide +kernel
    rw [refined]
    exact checked_1011101

private theorem checked_1011110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_188 = true := by
  apply checkBounds_from_children
  · exact checked_10111100
  · have refined : refineBuckets 7 buckets_188 = buckets_189 := by decide +kernel
    rw [refined]
    exact checked_10111101

private theorem checked_1011111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_190 = true := by
  apply checkBounds_from_children
  · exact checked_10111110
  · have refined : refineBuckets 7 buckets_190 = buckets_191 := by decide +kernel
    rw [refined]
    exact checked_10111111

private theorem checked_101111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_188 = true := by
  apply checkBounds_from_children
  · exact checked_1011110
  · have refined : refineBuckets 6 buckets_188 = buckets_190 := by decide +kernel
    rw [refined]
    exact checked_1011111

private theorem checked_10111 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_184 = true := by
  apply checkBounds_from_children
  · exact checked_101110
  · have refined : refineBuckets 5 buckets_184 = buckets_188 := by decide +kernel
    rw [refined]
    exact checked_101111

private theorem checked_1011 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_176 = true := by
  apply checkBounds_from_children
  · exact checked_10110
  · have refined : refineBuckets 4 buckets_176 = buckets_184 := by decide +kernel
    rw [refined]
    exact checked_10111

private theorem checked_101 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_160 = true := by
  apply checkBounds_from_children
  · exact checked_1010
  · have refined : refineBuckets 3 buckets_160 = buckets_176 := by decide +kernel
    rw [refined]
    exact checked_1011

private theorem checked_10 : checkBounds [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_100
  · have refined : refineBuckets 2 buckets_128 = buckets_160 := by decide +kernel
    rw [refined]
    exact checked_101

private theorem checked_1100000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_11000000
  · have refined : refineBuckets 7 buckets_192 = buckets_193 := by decide +kernel
    rw [refined]
    exact checked_11000001

private theorem checked_1100001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_194 = true := by
  apply checkBounds_from_children
  · exact checked_11000010
  · have refined : refineBuckets 7 buckets_194 = buckets_195 := by decide +kernel
    rw [refined]
    exact checked_11000011

private theorem checked_110000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_1100000
  · have refined : refineBuckets 6 buckets_192 = buckets_194 := by decide +kernel
    rw [refined]
    exact checked_1100001

private theorem checked_1100010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_196 = true := by
  apply checkBounds_from_children
  · exact checked_11000100
  · have refined : refineBuckets 7 buckets_196 = buckets_197 := by decide +kernel
    rw [refined]
    exact checked_11000101

private theorem checked_1100011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_198 = true := by
  apply checkBounds_from_children
  · exact checked_11000110
  · have refined : refineBuckets 7 buckets_198 = buckets_199 := by decide +kernel
    rw [refined]
    exact checked_11000111

private theorem checked_110001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_196 = true := by
  apply checkBounds_from_children
  · exact checked_1100010
  · have refined : refineBuckets 6 buckets_196 = buckets_198 := by decide +kernel
    rw [refined]
    exact checked_1100011

private theorem checked_11000 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_110000
  · have refined : refineBuckets 5 buckets_192 = buckets_196 := by decide +kernel
    rw [refined]
    exact checked_110001

private theorem checked_1100100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_200 = true := by
  apply checkBounds_from_children
  · exact checked_11001000
  · have refined : refineBuckets 7 buckets_200 = buckets_201 := by decide +kernel
    rw [refined]
    exact checked_11001001

private theorem checked_1100101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_202 = true := by
  apply checkBounds_from_children
  · exact checked_11001010
  · have refined : refineBuckets 7 buckets_202 = buckets_203 := by decide +kernel
    rw [refined]
    exact checked_11001011

private theorem checked_110010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_200 = true := by
  apply checkBounds_from_children
  · exact checked_1100100
  · have refined : refineBuckets 6 buckets_200 = buckets_202 := by decide +kernel
    rw [refined]
    exact checked_1100101

private theorem checked_1100110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_204 = true := by
  apply checkBounds_from_children
  · exact checked_11001100
  · have refined : refineBuckets 7 buckets_204 = buckets_205 := by decide +kernel
    rw [refined]
    exact checked_11001101

private theorem checked_1100111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_206 = true := by
  apply checkBounds_from_children
  · exact checked_11001110
  · have refined : refineBuckets 7 buckets_206 = buckets_207 := by decide +kernel
    rw [refined]
    exact checked_11001111

private theorem checked_110011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_204 = true := by
  apply checkBounds_from_children
  · exact checked_1100110
  · have refined : refineBuckets 6 buckets_204 = buckets_206 := by decide +kernel
    rw [refined]
    exact checked_1100111

private theorem checked_11001 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_200 = true := by
  apply checkBounds_from_children
  · exact checked_110010
  · have refined : refineBuckets 5 buckets_200 = buckets_204 := by decide +kernel
    rw [refined]
    exact checked_110011

private theorem checked_1100 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_11000
  · have refined : refineBuckets 4 buckets_192 = buckets_200 := by decide +kernel
    rw [refined]
    exact checked_11001

private theorem checked_1101000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_208 = true := by
  apply checkBounds_from_children
  · exact checked_11010000
  · have refined : refineBuckets 7 buckets_208 = buckets_209 := by decide +kernel
    rw [refined]
    exact checked_11010001

private theorem checked_1101001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_210 = true := by
  apply checkBounds_from_children
  · exact checked_11010010
  · have refined : refineBuckets 7 buckets_210 = buckets_211 := by decide +kernel
    rw [refined]
    exact checked_11010011

private theorem checked_110100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_208 = true := by
  apply checkBounds_from_children
  · exact checked_1101000
  · have refined : refineBuckets 6 buckets_208 = buckets_210 := by decide +kernel
    rw [refined]
    exact checked_1101001

private theorem checked_1101010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_212 = true := by
  apply checkBounds_from_children
  · exact checked_11010100
  · have refined : refineBuckets 7 buckets_212 = buckets_213 := by decide +kernel
    rw [refined]
    exact checked_11010101

private theorem checked_1101011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_214 = true := by
  apply checkBounds_from_children
  · exact checked_11010110
  · have refined : refineBuckets 7 buckets_214 = buckets_215 := by decide +kernel
    rw [refined]
    exact checked_11010111

private theorem checked_110101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_212 = true := by
  apply checkBounds_from_children
  · exact checked_1101010
  · have refined : refineBuckets 6 buckets_212 = buckets_214 := by decide +kernel
    rw [refined]
    exact checked_1101011

private theorem checked_11010 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_208 = true := by
  apply checkBounds_from_children
  · exact checked_110100
  · have refined : refineBuckets 5 buckets_208 = buckets_212 := by decide +kernel
    rw [refined]
    exact checked_110101

private theorem checked_1101100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_216 = true := by
  apply checkBounds_from_children
  · exact checked_11011000
  · have refined : refineBuckets 7 buckets_216 = buckets_217 := by decide +kernel
    rw [refined]
    exact checked_11011001

private theorem checked_1101101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_218 = true := by
  apply checkBounds_from_children
  · exact checked_11011010
  · have refined : refineBuckets 7 buckets_218 = buckets_219 := by decide +kernel
    rw [refined]
    exact checked_11011011

private theorem checked_110110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_216 = true := by
  apply checkBounds_from_children
  · exact checked_1101100
  · have refined : refineBuckets 6 buckets_216 = buckets_218 := by decide +kernel
    rw [refined]
    exact checked_1101101

private theorem checked_1101110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_220 = true := by
  apply checkBounds_from_children
  · exact checked_11011100
  · have refined : refineBuckets 7 buckets_220 = buckets_221 := by decide +kernel
    rw [refined]
    exact checked_11011101

private theorem checked_1101111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_222 = true := by
  apply checkBounds_from_children
  · exact checked_11011110
  · have refined : refineBuckets 7 buckets_222 = buckets_223 := by decide +kernel
    rw [refined]
    exact checked_11011111

private theorem checked_110111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_220 = true := by
  apply checkBounds_from_children
  · exact checked_1101110
  · have refined : refineBuckets 6 buckets_220 = buckets_222 := by decide +kernel
    rw [refined]
    exact checked_1101111

private theorem checked_11011 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_216 = true := by
  apply checkBounds_from_children
  · exact checked_110110
  · have refined : refineBuckets 5 buckets_216 = buckets_220 := by decide +kernel
    rw [refined]
    exact checked_110111

private theorem checked_1101 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_208 = true := by
  apply checkBounds_from_children
  · exact checked_11010
  · have refined : refineBuckets 4 buckets_208 = buckets_216 := by decide +kernel
    rw [refined]
    exact checked_11011

private theorem checked_110 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_1100
  · have refined : refineBuckets 3 buckets_192 = buckets_208 := by decide +kernel
    rw [refined]
    exact checked_1101

private theorem checked_1110000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_224 = true := by
  apply checkBounds_from_children
  · exact checked_11100000
  · have refined : refineBuckets 7 buckets_224 = buckets_225 := by decide +kernel
    rw [refined]
    exact checked_11100001

private theorem checked_1110001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_226 = true := by
  apply checkBounds_from_children
  · exact checked_11100010
  · have refined : refineBuckets 7 buckets_226 = buckets_227 := by decide +kernel
    rw [refined]
    exact checked_11100011

private theorem checked_111000 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_224 = true := by
  apply checkBounds_from_children
  · exact checked_1110000
  · have refined : refineBuckets 6 buckets_224 = buckets_226 := by decide +kernel
    rw [refined]
    exact checked_1110001

private theorem checked_1110010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_228 = true := by
  apply checkBounds_from_children
  · exact checked_11100100
  · have refined : refineBuckets 7 buckets_228 = buckets_229 := by decide +kernel
    rw [refined]
    exact checked_11100101

private theorem checked_1110011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_230 = true := by
  apply checkBounds_from_children
  · exact checked_11100110
  · have refined : refineBuckets 7 buckets_230 = buckets_231 := by decide +kernel
    rw [refined]
    exact checked_11100111

private theorem checked_111001 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_228 = true := by
  apply checkBounds_from_children
  · exact checked_1110010
  · have refined : refineBuckets 6 buckets_228 = buckets_230 := by decide +kernel
    rw [refined]
    exact checked_1110011

private theorem checked_11100 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_224 = true := by
  apply checkBounds_from_children
  · exact checked_111000
  · have refined : refineBuckets 5 buckets_224 = buckets_228 := by decide +kernel
    rw [refined]
    exact checked_111001

private theorem checked_1110100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_232 = true := by
  apply checkBounds_from_children
  · exact checked_11101000
  · have refined : refineBuckets 7 buckets_232 = buckets_233 := by decide +kernel
    rw [refined]
    exact checked_11101001

private theorem checked_1110101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_234 = true := by
  apply checkBounds_from_children
  · exact checked_11101010
  · have refined : refineBuckets 7 buckets_234 = buckets_235 := by decide +kernel
    rw [refined]
    exact checked_11101011

private theorem checked_111010 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_232 = true := by
  apply checkBounds_from_children
  · exact checked_1110100
  · have refined : refineBuckets 6 buckets_232 = buckets_234 := by decide +kernel
    rw [refined]
    exact checked_1110101

private theorem checked_1110110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_236 = true := by
  apply checkBounds_from_children
  · exact checked_11101100
  · have refined : refineBuckets 7 buckets_236 = buckets_237 := by decide +kernel
    rw [refined]
    exact checked_11101101

private theorem checked_1110111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_238 = true := by
  apply checkBounds_from_children
  · exact checked_11101110
  · have refined : refineBuckets 7 buckets_238 = buckets_239 := by decide +kernel
    rw [refined]
    exact checked_11101111

private theorem checked_111011 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_236 = true := by
  apply checkBounds_from_children
  · exact checked_1110110
  · have refined : refineBuckets 6 buckets_236 = buckets_238 := by decide +kernel
    rw [refined]
    exact checked_1110111

private theorem checked_11101 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_232 = true := by
  apply checkBounds_from_children
  · exact checked_111010
  · have refined : refineBuckets 5 buckets_232 = buckets_236 := by decide +kernel
    rw [refined]
    exact checked_111011

private theorem checked_1110 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_224 = true := by
  apply checkBounds_from_children
  · exact checked_11100
  · have refined : refineBuckets 4 buckets_224 = buckets_232 := by decide +kernel
    rw [refined]
    exact checked_11101

private theorem checked_1111000 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_240 = true := by
  apply checkBounds_from_children
  · exact checked_11110000
  · have refined : refineBuckets 7 buckets_240 = buckets_241 := by decide +kernel
    rw [refined]
    exact checked_11110001

private theorem checked_1111001 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_242 = true := by
  apply checkBounds_from_children
  · exact checked_11110010
  · have refined : refineBuckets 7 buckets_242 = buckets_243 := by decide +kernel
    rw [refined]
    exact checked_11110011

private theorem checked_111100 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_240 = true := by
  apply checkBounds_from_children
  · exact checked_1111000
  · have refined : refineBuckets 6 buckets_240 = buckets_242 := by decide +kernel
    rw [refined]
    exact checked_1111001

private theorem checked_1111010 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_244 = true := by
  apply checkBounds_from_children
  · exact checked_11110100
  · have refined : refineBuckets 7 buckets_244 = buckets_245 := by decide +kernel
    rw [refined]
    exact checked_11110101

private theorem checked_1111011 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_246 = true := by
  apply checkBounds_from_children
  · exact checked_11110110
  · have refined : refineBuckets 7 buckets_246 = buckets_247 := by decide +kernel
    rw [refined]
    exact checked_11110111

private theorem checked_111101 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_244 = true := by
  apply checkBounds_from_children
  · exact checked_1111010
  · have refined : refineBuckets 6 buckets_244 = buckets_246 := by decide +kernel
    rw [refined]
    exact checked_1111011

private theorem checked_11110 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_240 = true := by
  apply checkBounds_from_children
  · exact checked_111100
  · have refined : refineBuckets 5 buckets_240 = buckets_244 := by decide +kernel
    rw [refined]
    exact checked_111101

private theorem checked_1111100 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_248 = true := by
  apply checkBounds_from_children
  · exact checked_11111000
  · have refined : refineBuckets 7 buckets_248 = buckets_249 := by decide +kernel
    rw [refined]
    exact checked_11111001

private theorem checked_1111101 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_250 = true := by
  apply checkBounds_from_children
  · exact checked_11111010
  · have refined : refineBuckets 7 buckets_250 = buckets_251 := by decide +kernel
    rw [refined]
    exact checked_11111011

private theorem checked_111110 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_248 = true := by
  apply checkBounds_from_children
  · exact checked_1111100
  · have refined : refineBuckets 6 buckets_248 = buckets_250 := by decide +kernel
    rw [refined]
    exact checked_1111101

private theorem checked_1111110 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_252 = true := by
  apply checkBounds_from_children
  · exact checked_11111100
  · have refined : refineBuckets 7 buckets_252 = buckets_253 := by decide +kernel
    rw [refined]
    exact checked_11111101

private theorem checked_1111111 : checkBounds [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 7 buckets_254 = true := by
  apply checkBounds_from_children
  · exact checked_11111110
  · have refined : refineBuckets 7 buckets_254 = buckets_255 := by decide +kernel
    rw [refined]
    exact checked_11111111

private theorem checked_111111 : checkBounds [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 6 buckets_252 = true := by
  apply checkBounds_from_children
  · exact checked_1111110
  · have refined : refineBuckets 6 buckets_252 = buckets_254 := by decide +kernel
    rw [refined]
    exact checked_1111111

private theorem checked_11111 : checkBounds [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 5 buckets_248 = true := by
  apply checkBounds_from_children
  · exact checked_111110
  · have refined : refineBuckets 5 buckets_248 = buckets_252 := by decide +kernel
    rw [refined]
    exact checked_111111

private theorem checked_1111 : checkBounds [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 4 buckets_240 = true := by
  apply checkBounds_from_children
  · exact checked_11110
  · have refined : refineBuckets 4 buckets_240 = buckets_248 := by decide +kernel
    rw [refined]
    exact checked_11111

private theorem checked_111 : checkBounds [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 3 buckets_224 = true := by
  apply checkBounds_from_children
  · exact checked_1110
  · have refined : refineBuckets 3 buckets_224 = buckets_240 := by decide +kernel
    rw [refined]
    exact checked_1111

private theorem checked_11 : checkBounds [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 2 buckets_192 = true := by
  apply checkBounds_from_children
  · exact checked_110
  · have refined : refineBuckets 2 buckets_192 = buckets_224 := by decide +kernel
    rw [refined]
    exact checked_111

private theorem checked_1 : checkBounds [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 1 buckets_128 = true := by
  apply checkBounds_from_children
  · exact checked_10
  · have refined : refineBuckets 1 buckets_128 = buckets_192 := by decide +kernel
    rw [refined]
    exact checked_11

private theorem checked_root : checkBounds [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] 0 [searchedWords] = true := by
  apply checkBounds_from_children
  · exact checked_0
  · have refined : refineBuckets 0 [searchedWords] = buckets_128 := by decide +kernel
    rw [refined]
    exact checked_1

/-- Each surviving coordinate subset satisfies the root replay. -/
theorem checked_search : checkBounds (List.finRange 18) 0 [searchedWords] = true := by
  have grid : List.finRange 18 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] := by decide +kernel
  rw [grid]
  exact checked_root

end TwoColorNullity.PublishedInstance

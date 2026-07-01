import re

test_str = "linalg.batch_matmul ins(%arg27, %alloc_13 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<2x128x384xf32>) outs(%alloc_15 : memref<2x1024x384xf32>)"
pattern = r"linalg\.batch_matmul\s+ins\(([^,]+),\s*([^:]+)\s*:\s*(memref<.*?>|memref<.*?>>),\s*(memref<.*?>|memref<.*?>>)\)\s*outs\(([^:]+)\s*:\s*(memref<.*?>|memref<.*?>>)\)"

pattern2 = r"linalg\.batch_matmul\s+ins\(([^,]+),\s*([^:]+)\s*:\s*(.+?),\s*(memref<.+)\)\s*outs\(([^:]+)\s*:\s*(.+)\)"

matches = re.search(pattern2, test_str)
if matches:
    print("MATCH 1:", matches.group(1))
    print("MATCH 2:", matches.group(2))
    print("MATCH 3:", matches.group(3))
    print("MATCH 4:", matches.group(4))
    print("MATCH 5:", matches.group(5))
    print("MATCH 6:", matches.group(6))
else:
    print("NO MATCH")

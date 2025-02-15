/// created by wangjuwudi
/// include counting_sort、radix_sort and bucket_sort
/// version 0.0.1


///|
/// Counting Sort
/// input Array must be Array[Int], every element must be above zero
pub fn counting_sort(arr : Array[Int]) -> Array[Int] {
  let mut max_value = arr[0]
  for x in arr{
    if x > max_value {
      max_value = x
    }
  }

  let count= Array::make(max_value + 1, 0)
  for x in arr {
    count[x] += 1
  }
  
  let mut index = 0
  for i = 0; i <= max_value; i = i + 1{
    while count[i] > 0 {
      arr[index] = i
      index += 1
      count[i] -= 1
    }
  }
  arr
}

///|
/// Radix Sort
/// input Array must be Array[Int], every element must be above zero
pub fn radix_sort(arr : Array[Int]) -> Array[Int] {
  let m = getmax_exp(arr)
  for exp = 1; m / exp > 0; exp = exp * 10{
    help_sort(arr, exp)
  }
  arr
}

pub fn getmax_exp(arr : Array[Int]) -> Int {
  let mut mx = arr[0]
  for x in arr {
    if mx < x {
      mx = x
    }
  }
  let mut res = 1
  while mx / res > 0{
    res *= 10
  }
  res
}

pub fn help_sort(arr : Array[Int], exp : Int) -> Unit {
  let count = Array::make(10, 0)
  let arr_temp = Array::make(arr.length(), 0)
  for x in arr {
    count[(x / exp) % 10] += 1
  }
  for i = 1; i < 10; i = i + 1 {
    count[i] += count[i - 1]
  }
  for i = arr.length()-1; i >= 0; i = i - 1 {
    arr_temp[count[(arr[i] / exp) % 10] - 1] = arr[i]
    count[arr[i] / exp % 10] -= 1
  }
  for i = 0; i < arr.length(); i = i + 1 {
    arr[i] = arr_temp[i]
  }
}

///|
/// Bucket Sort
/// input Array must be Array[Int]
pub fn bucket_sort(arr : Array[Int]) -> Array[Int] {
  let n = arr.length()
  if n <= 1 {
    return arr
  }
  
  let mut minVal = arr[0]
  let mut maxVal = arr[0]
  for x in arr {
    if x < minVal {
      minVal = x
    }
    if x > maxVal {
      maxVal = x
    }
  }

  let bucketCount = maxVal - minVal + 1
  let buckets :Array[Array[Int]]= []
  for i = 0; i < bucketCount; i = i + 1 {
    let bucket_temp = [Array::make(n+1,0)]
    buckets.append(bucket_temp)
  } 

  for i = 0; i < n; i = i + 1 {
    let index = arr[i] - minVal
    buckets[index][0] += 1
    buckets[index][buckets[index][0]] = arr[i]
  }
 
  let mut index = 0
  for i = 0; i < bucketCount; i = i + 1 {
    if buckets[i][0] > 0 {
      insert_sort(buckets[i], buckets[i][0])
      for j = 1; j <= buckets[i][0]; j = j + 1 {
        arr[index] = buckets[i][j]
        index += 1
      }
    }
  }
  arr
}

pub fn insert_sort(arr : Array[Int],n : Int) -> Unit {
  for i = 1; i <= n; i = i + 1 {
    let key = arr[i]
    let mut j = i - 1
    while j >= 1 && arr[j] > key {
      arr[j + 1] = arr[j]
      j = j - 1
    }
    arr[j + 1] = key
  }
}
import java.util.ArrayList
import java.util.Collections
import java.util.List
import java.util.Random

# Merge sort in Mirah to get a feel for the language
# Implements the pseudo code from Wikipedia

def merge_sort(m:List): List
  if m.size <= 1
    return m
  end
  
  middle = m.size / 2
  left = merge_sort ArrayList.new m.subList(0,middle)
  right = merge_sort ArrayList.new m.subList(middle, m.size)

  return merge(left, right)
end

def merge(left:List, right:List):List
  result = ArrayList.new
  
  while left.size > 0 or right.size > 0
    if left.size > 0 and right.size > 0
      if Integer(left.get(0)).intValue <= Integer(right.get(0)).intValue
        result.add left.get(0)
        left.remove(0)
      else
        result.add right.get(0)
        right.remove(0)
      end
    else
      if left.size > 0
        result.add left.get(0)
        left.remove(0)
      else
        if right.size > 0
          result.add right.get(0)
          right.remove(0)
        end
      end
    end
  end

  return result
end

def assert(result:boolean, message:string)
  if not result
    raise message
  end
end

puts "Testing for sorting errors"

rand = Random.new
100.times do
  list = ArrayList.new
  size = rand.nextInt(1000) + 1000
  size.times do
    list.add Integer.new(rand.nextInt)
  end

  Collections.sort(list)
  list2 = ArrayList.new list

  assert list.equals(merge_sort(list2)), "Sorting is broken"

  print "."
end

puts " OK"

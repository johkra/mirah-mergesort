import java.util.ArrayList
import java.util.Collections
import java.util.List
import java.util.Random

# Merge sort in Mirah to get a feel for the language
# Implements the pseudo code from Wikipedia

### Helpers

def slice(list:List, from:int, to:int):List
  list.subList(from, to)
end

def slice(list:List, from:int):List
  list.subList(from, list.size)
end

macro def to_i(i:Object):int
  quote do
    Integer(`i`).intValue
  end
end

###

def merge_sort(m:List): List
  if m.size <= 1
    return m
  end
  
  middle = m.size / 2
  left = merge_sort(slice(m, 0, middle))
  right = merge_sort(slice(m, middle))

  return merge(left, right)
end

def merge(left:List, right:List):List
  result = ArrayList.new
  
  while left.size > 0 or right.size > 0
    if left.size > 0 and right.size > 0
      if to_i(left.get(0)) <= to_i(right.get(0))
        result.add left.get(0)
        left = slice(left, 1)
      else
        result.add right.get(0)
        right = slice(right, 1)
      end
    elsif left.size > 0
      result.add left.get(0)
      left = slice(left, 1)
    elsif right.size > 0
      result.add right.get(0)
      right = slice(right, 1)
    end
  end

  result
end

def check(result:boolean, message:string)
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

  check(list.equals(merge_sort(list2)), "Sorting is broken")

  print "."
end

puts " OK"

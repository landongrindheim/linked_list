# ( linked -> list )

A curiosity-driven exercise creating an immutable linked list in Ruby

Since this was an exercise, a procedural style was intentionally used.
Enumerable was avoided, with the exception of `#to_s`, though perhaps
decoupling the method from the mixin is the next step to take here.

### [[:implements:]]
* `#peek`   -> `{ aka: [ :first ] }`
* `#last`
* `#next`   -> `{ aka: [ :tail ] }`
* `#next?`
* `#pop`
* `#pop_n`
* `#push`   -> `{ aka: [ :prepend, :insert, :add_first, :add ] }`
* `#append` -> `{ aka: [ :add_last ] }`
* `#value_at`
* `#add_all`
* `#delete`
* `#contains?`
* `#length`
* `#reverse`
* `#each`   -> `{ and_with_it: *Enumerable.methods }`
* `#to_s`


## ( usage )

```Ruby
  [1] pry(main)> list = LinkedList.new(1)
  => #<LinkedList:0x007ff46d8cb590
   @head=#<LinkedList::Node:0x007ff46d8cb298 @data=1, @tail=nil>>
  [2] pry(main)> list = list.push(2)
  => #<LinkedList:0x007ff46d0e1488
   @head=
    #<LinkedList::Node:0x007ff46d0e14d8
     @data=2,
     @tail=#<LinkedList::Node:0x007ff46d8cb298 @data=1, @tail=nil>>>
  [3] pry(main)> list.pop
  => #<LinkedList:0x007ff46c9567e0
   @head=#<LinkedList::Node:0x007ff46d8cb298 @data=1, @tail=nil>>
```

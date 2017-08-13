require_relative "linked_list"

RSpec.describe LinkedList do
  describe "#peek, #first" do
    it "returns the data at the head of a list" do
      list = LinkedList.new(1)

      expect(list.peek).to eq(1)
      expect(list.first).to eq(1)
    end
  end

  describe "#last" do
    it "returns the data of the last element of the list" do
      list = LinkedList.new("first")
      list = list.append("last")

      expect(list.last).to eq("last")
    end
  end

  describe "#next, #tail, #pop" do
    context "when a list has a head and a non-empty tail" do
      it "returns a list comprised of the original list's tail" do
        list = LinkedList.new("original head")
        list = list.prepend("new head")

        the_tail = list.next

        expect(the_tail).to be_a LinkedList
        expect(the_tail.length).to eq(list.length - 1)
        expect(the_tail.peek).to eq("original head")
      end
    end

    context "when a list has only a head" do
      it "returns nil" do
        list = LinkedList.new("head")

        the_tail = list.next

        expect(the_tail).to be_nil
      end
    end
  end

  describe "#next?" do
    context "when a list has a head and a non-empty tail" do
      it "returns true" do
        list = LinkedList.new("original head")
        list_with_tail = list.prepend("new head")

        expect(list_with_tail.next?).to eq(true)
      end
    end

    context "when a list has only a head" do
      it "returns false" do
        single_element_list = LinkedList.new("head")

        expect(single_element_list.next?).to eq(false)
      end
    end
  end

  describe "#pop_n" do
    context "when the argument is less than the length of the list" do
      it "returns a copy of the list minus the number of elements" do
        list = LinkedList.new("original")

        5.times { |n| list = list.prepend(n) }

        expect(list.length).to eq(6)

        pop_5 = list.pop_n(5)

        expect(pop_5).to be_a LinkedList
        expect(pop_5.length).to eq(1)
        expect(pop_5.peek).to eq("original")
      end
    end

    context "when the argument is greater than or equal to the list's length" do
      it "returns nil" do
        list = LinkedList.new(1)
        5.times { |n| list = list.prepend(n) }

        expect(list.length).to eq(6)

        expect(list.pop_n(6)).to be_nil
        expect(list.pop_n(300)).to be_nil
      end
    end
  end

  describe "#prepend, #insert, #push, #add_first, #add" do
    it "adds an element to the head of a copy of a list" do
      list = LinkedList.new("bar")

      prepened_list = list.prepend("foo")

      expect(prepened_list.first).to eq("foo")
    end
  end

  describe "#append, #add_last" do
    it "adds an element to the head of a copy of a list" do
      list = LinkedList.new("foo")

      appended_list = list.append("baz")

      expect(appended_list.last).to eq("baz")
    end
  end

  describe "#add_all" do
    it "adds all elements of an enumerable collection" do
      list = LinkedList.new(0)
      one_through_five = (1..5).to_a

      list_with_one_through_five = list.add_all(one_through_five)

      one_through_five.each do |n|
        expect(list_with_one_through_five.contains?(n)).to eq(true)
      end
    end
  end

  describe "#delete" do
    context "when a list contains an element matching the argument" do
      it "removes first the element matching the argument" do
        list_with_three = LinkedList.new(1).add_all(2..4)

        expect(list_with_three.contains?(3)).to eq(true)

        list_without_three = list_with_three.delete(3)

        expect(list_without_three.contains?(3)).to eq(false)
      end
    end

    context "when a list doesn't contain an element matching the argument" do
      it "returns the list" do
        list_without_five = LinkedList.new(1).add_all(2..4)

        expect(list_without_five.contains?(5)).to eq(false)

        expect(list_without_five.delete(5)).to eq(list_without_five)
      end
    end
  end

  describe "#contains?" do
    context "when the argument matches the value of an element of the list" do
      it "returns true" do
        list = LinkedList.new("yes")

        expect(list.contains?("yes")).to eq(true)
      end
    end

    context "when the argument does not match any element in the list" do
      it "returns false" do
        list = LinkedList.new("no")

        expect(list.contains?("yes")).to eq(false)
      end
    end
  end

  describe "#length" do
    it "returns a count of the number of elements in a list" do
      one = LinkedList.new(1)
      one_and_six_more = (2..7).inject(one) { |list, n| list = list.prepend(n) }

      expect(one_and_six_more.length).to eq(7)
    end
  end

  describe "#reverse" do
    it "returns a copy of the list backward" do
      two = LinkedList.new(2)
      one_and_two = two.prepend(1)

      expect(one_and_two.first).to eq(1)
      expect(one_and_two.last).to eq(2)

      reversed_one_and_two = one_and_two.reverse

      expect(reversed_one_and_two.first).to eq(2)
      expect(reversed_one_and_two.last).to eq(1)
    end
  end

  describe "#value_at" do
    context "when the argument is within the bounds of the list" do
      it "returns the value mapped to the argument" do
        list = LinkedList.new("even")
        (1..5).each { |n| list = list.prepend(n.even? ? "even" : "odd") }

        expect(list.length).to eq(6)

        expect(list.value_at(2)).to eq("odd")
        expect(list.value_at(5)).to eq("even")
      end
    end

    context "when the argument is outside the bounds of the list" do
      it "returns nil" do
        list = LinkedList.new(1)
        5.times { |n| list = list.prepend(n) }

        expect(list.length).to eq(6)

        expect(list.value_at(9)).to be_nil
        expect(list.value_at(6)).to be_nil
        expect(list.value_at(5)).not_to be_nil
      end
    end
  end

  describe "#to_s" do
    it "returns the data values of a list, separated by commas" do
      one = LinkedList.new(1)
      two_one = one.prepend(2)
      three_to_one = two_one.prepend(3)

      expect(three_to_one.to_s).to eq("3, 2, 1")
    end
  end
end

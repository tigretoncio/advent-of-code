=begin
--- Day 2: I Was Told There Would Be No Math ---

The elves are running low on wrapping paper, and so they need to submit an order for more. They have a list of the dimensions (length l, width w, and height h) of each present, and only want to order exactly as much as they need.

Fortunately, every present is a box (a perfect right rectangular prism), which makes calculating the required wrapping paper for each gift a little easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l. The elves also need a little extra paper for each present: the area of the smallest side.

For example:

A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.
A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.
All numbers in the elves' list are in feet. How many total square feet of wrapping paper should they order?

To begin, get your puzzle input.

http://adventofcode.com/day/2/input

=end

class WrappingPaper

    FILE = "day2/day2.txt"

    def initialize()
      @gift_measures ||= get_raw_data(FILE)
    end

    def calculate_wrap()
      paper_needed = 0
      gift_measures.each do |gift_box|
        measure = extract_box_dimension(gift_box)
        paper_needed += calculate_wrap_per_paper(measure)
      end
      paper_needed
    end

    def calc_ribbon()
      ribbon_needed = 0
      gift_measures.each do |gift_box|
        measure = extract_box_dimension(gift_box)
        ribbon_needed += calculate_ribbon_length(measure)
      end
      ribbon_needed
    end

    private

    attr_reader :gift_measures

    def get_raw_data(file)
      data = File.read(file)
      data.split("\n")
    end

    def extract_box_dimension(line)
      dimensions = line.split("x")
      dimensions.map { |str| str.to_i }
    end

    def calculate_wrap_per_paper(dimensions)
      l, w, h = dimensions
      calculate_paper_strict(l,w,h) + calculate_paper_slack(dimensions)
    end

    def calculate_paper_strict(l,w,h)
      2*l*w + 2*w*h + 2*h*l
    end

    def calculate_paper_slack(dimensions)
      dimensions.sort!
      dimensions[0] * dimensions[1]
    end

    def calculate_ribbon_length(dimensions)
      calculate_ribbon_wrap(dimensions) + calculate_bow_length(dimensions)
    end

    def calculate_ribbon_wrap(dimensions)
      dimensions.sort!
      2*(dimensions[0] + dimensions[1])
    end

    def calculate_bow_length(dimensions)
      l, w, h = dimensions
      l*w*h
    end

end


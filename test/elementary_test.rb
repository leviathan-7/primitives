require "./test/test_helper"

class ElementaryTest < Minitest::Test
  include Primitives

  @@delta = 1e-5

  def setup
    @point = Elementary::Point.new(2.3, 5.1)
    @point2 = Elementary::Point.new(3, 3)
    @s_line1 = Elementary::StraightLine.new(3, 2, 1)
    @s_line2 = Elementary::StraightLine.new(5, -6, -1)
  end

  def test_point_attributes_set_correctly_on_instance_create
    assert_in_delta 2.3, @point.x, @@delta
    assert_in_delta 5.1, @point.y, @@delta
  end

  def test_point_initializer_rises_type_error_if_arguments_dont_satisfy_the_requirement_type
    assert_raises TypeError do
      Elementary::Point.new(1.2, "3")
    end
  end

  def test_move_method_correctly_moved_the_point
    p = @point.move 5, 5

    assert_in_delta 7.3, p.x, @@delta
    assert_in_delta 10.1, p.y, @@delta
  end

  def test_dangerous_move_method_correctly_moved_the_point
    p = @point.dup
    p.move! 5, 5

    assert_in_delta 7.3, p.x, @@delta
    assert_in_delta 10.1, p.y, @@delta
  end

  def test_move_method_doesnt_affect_point_instance_on_which_it_was_applied
    original = @point
    _ = original.move 777, 777

    assert_in_delta 2.3, original.x, @@delta
    assert_in_delta 5.1, original.y, @@delta
  end

  def test_distance_between_point_and_straightline
    distance1 = @s_line1.shortest_distance_point @point
    distance2 = @s_line1.shortest_distance_point @point2
    assert_in_delta 5.020036, distance1, @@delta
    assert_in_delta 4.437601, distance2, @@delta
  end

  def test_check_line_intersection
    assert @s_line1.check_line_intersection @s_line2

    @s_line_float1 = Elementary::StraightLine.new(1.1, 2.2, 3.3)
    @s_line_float2 = Elementary::StraightLine.new(1.1, 2.2, 3.4)
    assert @s_line_float1.check_line_intersection @s_line_float2

    parallel_to_s_line1 = Elementary::StraightLine.new(3, 2, -5)
    assert @s_line1.check_line_intersection parallel_to_s_line1
  end

  def test_line_intersect
    point = @s_line1.line_intersection @s_line2
    assert_in_delta point.x, -0.14285, @@delta
    assert_in_delta point.y, -0.28571, @@delta

    parallel_to_s_line1 = Elementary::StraightLine.new(3, 2, -5)
    point1 = @s_line1.line_intersection parallel_to_s_line1
    assert_nil nil, point1
  end

end

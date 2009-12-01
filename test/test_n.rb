require 'helper'

class TestN < Test::Unit::TestCase
  should "call notify-send" do
    mock(self).system("notify-send", "--urgency=normal", "--expire-time=5", "--", "test/test_n.rb", "&quot;test&quot;\n")
    n('test')

    mock(self).system.with_any_args.twice
    n('foo', 'bar')
  end

  should "return args" do
    stub(self).system.with_any_args

    assert_equal nil, n
    assert_equal 'foo', n('foo')
    assert_equal ['foo', 'bar'], n('foo', 'bar')
    block = lambda {}
    assert_equal block, n(&block)
  end
end

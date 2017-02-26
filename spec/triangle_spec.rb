require File.expand_path(File.dirname(__FILE__) + '/../triangle_command')

# 期待される出力を定数化しておく
INVALID = "入力値が異常です"
NOT_TRIANGLE = "三角形じゃないです＞＜"
ORDINARY = "三角形ですね！"
ISOSCALES = "二等辺三角形ですね！"
EQUILATERAL = "正三角形ですね！"
ERROR_FRAGMENT = "ERROR" # エラーメッセージの断片

describe Triangle do

  describe "引数の数が3個でないとき、エラーを返す" do
    specify {expect(Triangle.run(["1", "2"])).to include ERROR_FRAGMENT }
    specify {expect(Triangle.run(["1", "2", "3", "4"])).to include ERROR_FRAGMENT }
  end

  describe "1辺以上の値が0ならば、三角形とみなされない" do
    specify { expect(Triangle.run(["0", "3", "4"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2", "0", "4"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2", "3", "0"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2", "0", "0"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["0", "3", "0"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["0", "0", "4"])).to eq NOT_TRIANGLE }
  end

  describe "1辺以上の値が数値でないならば、三角形とみなされない" do
    specify { expect(Triangle.run(["aaa",  "3",    "4"   ])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2",    "aaa",  "4"   ])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2",    "3",    "aaa" ])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2",    "aaa",  "aaa" ])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["aaa",  "3",    "aaa" ])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["aaa",  "aaa",  "4"   ])).to eq NOT_TRIANGLE }
  end

  describe "c=a+bのとき、三角形とみなされない。c=a+b-1のとき、三角形とみなされる。" do
    specify { expect(Triangle.run(["2", "4", "6"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["2", "4", "5"])).to eq ORDINARY }
  end

  describe "a=b+cのとき、三角形とみなされない。a=b+c-1のとき、三角形とみなされる。" do
    specify { expect(Triangle.run(["8", "5", "3"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["7", "5", "3"])).to eq ORDINARY }
  end

  describe "b=a+cのとき、三角形とみなされない。b=a+c-1のとき、三角形とみなされる。" do
    specify { expect(Triangle.run(["4", "10", "6"])).to eq NOT_TRIANGLE }
    specify { expect(Triangle.run(["4", "9",  "6"])).to eq ORDINARY }
  end

  describe "a=b=cのとき、正三角形とみなされる" do
    specify { expect(Triangle.run(["5", "5", "5"])).to eq EQUILATERAL }
  end

  describe "a,b,cのうち2つだけが等しいとき、二等辺三角形とみなされる" do
    specify { expect(Triangle.run(["3", "7", "7"])).to eq ISOSCALES }
    specify { expect(Triangle.run(["8", "4", "8"])).to eq ISOSCALES }
    specify { expect(Triangle.run(["9", "9", "5"])).to eq ISOSCALES }
  end

  describe "a,b,cがそれぞれ異なり、三角形の成立条件を満たすとき、普通の三角形とみなされる" do
    specify { expect(Triangle.run(["3", "4", "5"])).to eq ORDINARY }
  end
end

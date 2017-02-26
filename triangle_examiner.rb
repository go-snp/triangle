require "./triangle_type.rb"

###########################
# 三角形の型を調べるクラス。
# 責務は三角形の型を判定して返すことであって、コマンドライン周りの仕事は関知しない。
###########################
class TriangleExaminer

  # 与えられた3つの整数を三角形の3辺の長さとみなし、
  # 三角形の型を判定してTriangleType型で返す。
  # [引数]
  # int以外が渡されたときの動作を保証しない。
  # 配列ではなくばらばらになっているのは、要素数を固定するため。
  def self.examine(a, b, c)

    edges = [a, b, c]

    # 一般化して解くため、与えられた3辺を小さい順にソートしておく。
    # a <= b <= cならば， b+c > aとa+c > bは保障される。
    #（ただしa,b,cは0より大きいとする）
    edges = edges.sort

    # 0以下の値および無効な値が含まれていれば、三角形でないとみなす
    for i in 0..2 do
      value_to_check = edges[i]
      if (value_to_check <= 0) then
        return TriangleType::NOT_TRIANGLE
      end
    end

    # a+b > cのみを検査する。他はソートによって保障されている。
    if (edges[0] + edges[1] <= edges[2]) then
      return TriangleType::NOT_TRIANGLE
    end

    # この時点で三角形であると確定
    # あとは正三角形と二等辺三角形を検査

    # 正三角形
    if ((edges[0] == edges[1]) && (edges[1] == edges[2])) then
      return TriangleType::EQUILATERAL
    end

    # 二等辺三角形
    if ((edges[0] == edges[1]) || (edges[1] == edges[2]) || (edges[0] == edges[2])) then
      return TriangleType::ISOSCALES
    end

    # 残ったケースは一般の三角形
    return TriangleType::ORDINARY
  end

end

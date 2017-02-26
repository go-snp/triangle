require "./triangle_examiner.rb"
require "./message.rb"

############################
# コマンドを実装するクラス。
############################
class Triangle

  # コマンドの実行結果をメッセージで返す。
  def self.run(argv)

    # 入力配列の長さが3でない場合、エラーを返す
    num_of_args = argv.length
    if (num_of_args != 3) then
      return "ERROR: 引数が" + num_of_args.to_s + "個指定されています。3個にしてください。"
    end

    # 配列に引数を格納
    edges = [0, 0, 0]
    for i in 0..2 do
      edges[i] = argv[i].to_i
    end

    # 三角形判定処理はデリゲートする
    triangle_type = TriangleExaminer.examine(edges[0], edges[1], edges[2])

    # 戻り値で三角形の型を判定し、メッセージを表示
    case triangle_type
    when TriangleType::NOT_TRIANGLE then
      return NOT_TRIANGLE
    when TriangleType::ORDINARY then
      return ORDINARY
    when TriangleType::ISOSCALES then
      return ISOSCALES
    when TriangleType::EQUILATERAL then
      return EQUILATERAL
    else
      return "このプランチへの到達は想定されていません。プログラムエラーの可能性があります"
    end

  end
end

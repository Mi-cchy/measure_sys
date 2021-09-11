import ffmpeg

def video_trimming(input_file_path, start_x, start_y, w, h):
    """
    input_file_path # ファイルの絶対パス
    start_x = 850  # 切り取りたい区画のx座標（px）
    start_y = 500  # 切り取りたい区画のy座標（px）
    width = 700  # 切り取りたい区画の幅（px）
    height = 580  # 切り取りたい区画の高さ（px）
    """

    # トリミングファイル・パラメータ指定
    stream = ffmpeg.input(input_file_path)
    stream = ffmpeg.crop(stream, start_x, start_y, w, h)

    # 出力ファイル名生成
    output_file_str = input_file_path.split(".")
    output_file_name = output_file_str[0] + "_trimed." + output_file_str[1]
    stream = ffmpeg.output(stream, output_file_name)
    print("running")
    # 実行(ファイルがあると上書き)
    ffmpeg.run(stream, overwrite_output=True)

if __name__=='__main__':
    video_trimming("C:\\Users\\mitsuhiro\\Downloads\\sample.mp4", 720, 0, 720,960)

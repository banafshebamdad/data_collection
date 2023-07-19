import cv2
import numpy as np

def generate_aruco_markers(rows, cols, marker_size, output_file):
    dictionary = cv2.aruco.Dictionary_get(cv2.aruco.DICT_4X4_50)
    board = cv2.aruco.CharucoBoard_create(cols, rows, marker_size, marker_size, dictionary)

    canvas_size = (cols * marker_size, rows * marker_size)
    canvas = np.ones((canvas_size[1], canvas_size[0]), dtype=np.uint8) * 255

    for i in range(rows):
        for j in range(cols):
            marker_id = board.getMarkerId(i * cols + j)
            marker_img = cv2.aruco.drawMarker(dictionary, marker_id, marker_size)
            x, y = j * marker_size, i * marker_size
            canvas[y:y+marker_size, x:x+marker_size] = marker_img

    cv2.imwrite(output_file, canvas)
    print(f"Aruco markers generated and saved to {output_file}.")

# Generate 5x7 Aruco markers with a marker size of 200 pixels
generate_aruco_markers(5, 7, 200, "aruco_markers_A4.png")


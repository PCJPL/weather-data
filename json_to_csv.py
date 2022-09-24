import csv
import json
import sys

filter_keys = ["mic", "test", "channel", "center_frequency", "hop_times", "frequencies"]

models = ["LaCrosse-TX141W"]
fieldnames=['time', 'model', 'id', 'battery_ok', 'temperature_C', 'humidity', 'wind_avg_km_h', 'wind_dir_deg']

with open(sys.argv[1]) as input_file:
    with open(sys.argv[2], "w+") as output_file:

        writer = csv.DictWriter(output_file, fieldnames=fieldnames)
        writer.writeheader()

        for line in input_file:

            line_1 = json.loads(line)
            line_2 = json.loads(next(input_file))

            if (line_1.get("model") not in models) or (line_2.get("model") not in models):
                continue

            line_1.update(line_2)

            filtered_line_data = {k:v for (k,v) in line_1.items() if k not in filter_keys}
            writer.writerow(filtered_line_data)

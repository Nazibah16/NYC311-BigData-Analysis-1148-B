import requests
import csv
import os
import time

check="commit check"
URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.csv"

START_DATE = "2024-09-01T00:00:00"
END_DATE = "2026-09-01T00:00:00"

CHUNK_SIZE = 50000
OFFSET = 350000

os.makedirs("chunks", exist_ok=True)

while True:
    print(f"Downloading rows {OFFSET:,} to {OFFSET + CHUNK_SIZE - 1:,}...")

    params = {
        "$limit": CHUNK_SIZE,
        "$offset": OFFSET,
        "$where": f"created_date >= '{START_DATE}' AND created_date < '{END_DATE}'"
    }

    try:
        response = requests.get(URL, params=params, timeout=120)
        response.raise_for_status()

        rows = list(csv.reader(response.text.splitlines()))

        if len(rows) <= 1:
            print("No more data.")
            break

        filename = f"chunks/311_part_{OFFSET // CHUNK_SIZE + 1:04d}.csv"

        with open(filename, "w", newline="", encoding="utf-8") as f:
            f.write(response.text)

        print(f"Saved: {filename}")

        OFFSET += CHUNK_SIZE

        time.sleep(1)

    except Exception as e:
        print("Download failed:", e)
        print("Waiting 10 seconds and trying again...")
        time.sleep(10)

print("Download complete!")
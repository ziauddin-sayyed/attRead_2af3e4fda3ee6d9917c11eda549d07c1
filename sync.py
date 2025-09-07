from zk import ZK
import sys
from datetime import datetime

zk = ZK('192.168.0.101', port=4370, timeout=5)
conn = None

try:
    conn = zk.connect()
    conn.disable_device()

    attendance = conn.get_attendance()
    total = len(attendance)
    print("Total records fetched: {}".format(total))

    filename = "attendance.csv"

    with open(filename, "w") as f:
        f.write("User ID,Timestamp\n")
        for record in attendance:
            # record.timestamp is a datetime object; convert to string
            timestamp_str = record.timestamp.strftime("%Y-%m-%d %H:%M:%S")
            line = "{},{}\n".format(record.user_id, timestamp_str)
            f.write(line)

    print("Attendance data saved to {}".format(filename))

except Exception as e:
    print("Error:", e)

finally:
    if conn:
        conn.enable_device()
        conn.disconnect()

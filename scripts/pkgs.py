import re

pattern = re.compile(r"apk add -y(.*?)(^\s*$|^apk add -y)", re.MULTILINE | re.DOTALL)

filename = "setup_system_alpine_linux.sh"

with open(filename, "r") as file:
    text = file.read()

match = re.findall(pattern, text)

if match:
    for m in match:
        selected_text = m[0]
        print(selected_text)
else:
    print("No match found.")

from pathlib import Path
import re

months = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December"
    }


def is_entry(entry: str):
    return bool(re.match(r"\d\d\d\d-\d\d-\d\d\.md", entry))


def build_index(path):
    paths = path.split('~')
    if len(paths) == 2:
        wiki_dir = Path.home() / paths[1]
    else:
        wiki_dir = Path(path)
    diary_dir = wiki_dir / 'diary'
    output = [
        "# Diary\n",
            ]
    entries_r = [x for x in diary_dir.iterdir() if is_entry(x.name)]
    entries = entries_r[::-1]

    c_year = None
    c_month = None

    for entry in entries:
        match = re.match(r'(\d\d\d\d)-(\d\d)', entry.name)
        year = match[1]
        month = match[2]
        if c_year != year:
            c_year = year
            output.append("\n## " + c_year + "\n")
            c_month = month
            output.append("\n### " + months[c_month] + "\n\n")
        elif c_month != month:
            c_month = month
            output.append("\n### " + months[c_month] + "\n\n")
        link = f"- [{entry.name[:-3]}](./diary/{entry.name})\n"
        output.append(link)


    with open(diary_dir / "diary.md", "w") as outfile:
        outfile.writelines(output)

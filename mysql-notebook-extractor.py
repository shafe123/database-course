# this file reads the given mysql-notebook file and outputs a normal sql file.
import argparse
import json
from pathlib import Path


def read_file(input_file: str) -> str:
    with open(input_file, "r") as in_file:
        return str(json.loads(in_file.read())["content"])


def write_file(content: str, output_file: str, force: bool = False) -> None:
    if not force and Path(output_file).is_file():
        raise FileExistsError(f"{output_file} already exists.")

    with open(output_file, "w") as out_file:
        out_file.write(content)


def main(input_args: argparse.Namespace):
    input_file = input_args.inputFile

    if input_args.outputFile:
        output_file = input_args.outputFile
    else:
        output_file = f"{Path(input_file).stem}.sql"

    force_overwrite = input_args.force

    file_content = read_file(input_file)
    write_file(file_content, output_file, force_overwrite)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="MySQL Notebook Extractor",
        description="This file reads the given mysql-notebook file and outputs a normal sql file.",
    )

    parser.add_argument(
        "inputFile",
        help="The input mysql-notebook to parse.",
    )
    parser.add_argument(
        "-o",
        "--outputFile",
        const=True,
        help="The name of the output file.  If not specified, it will use the original filename with a .sql extension.",
        nargs="?",
        default=None,
    )
    parser.add_argument(
        "-f",
        "--force",
        help="Force overwrite the output destination.  Defaults to false",
        default=False,
        action="store_true",
    )

    args = parser.parse_args()
    main(args)

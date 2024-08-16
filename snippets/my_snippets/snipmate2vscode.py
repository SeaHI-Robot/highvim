"""
File: snipmate2vscode.py
Description: 该脚本目前八太行
"""

import json
import sys


def convert_snipmate_to_vscode(snipmate_content):
    with open(input_file_path, 'r') as file:
        snipmate_content = file.read()

    vscode_snippets = {}
    current_snippet = None

    for line in snipmate_content.split('\n'):
        # 跳过空行和注释行
        if not line.strip() or line.startswith('#'):
            continue

        # 开始一个新的snippet
        if line.startswith('snippet'):
            if current_snippet:
                # 在添加新snippet前，确保最后一个snippet被正确处理
                vscode_snippets[current_snippet["prefix"]] = current_snippet
            parts = line.split(' ')
            current_snippet = {
                "prefix": parts[1],
                "body": [],
                "description": ""
            }
            continue

        # 处理snippet描述
        if 'description' in current_snippet and not current_snippet["description"]:
            description_end_index = line.find('"')
            if description_end_index != -1:
                current_snippet["description"] = line[:description_end_index].strip(
                )
                continue

        # 添加snippet内容到body，去除行首的缩进（如果有的话）
        if current_snippet:
            current_snippet["body"].append(line.lstrip())

    # 确保最后一个snippet也被添加
    if current_snippet:
        vscode_snippets[current_snippet["prefix"]] = current_snippet

    # 生成最终的JSON字符串，并在snippet间添加空行
    vscode_snippets_str = json.dumps(vscode_snippets, indent=4)
    # 在每个snippet之间插入空行（通过字符串替换的方式）
    vscode_snippets_formatted = vscode_snippets_str.replace('},', '},\n\n')
    # 移除末尾不必要的空行
    if vscode_snippets_formatted.endswith(',\n\n}'):
        vscode_snippets_formatted = vscode_snippets_formatted[:-3] + '\n}'

    return vscode_snippets_formatted


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <input_file_path>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    try:
        result = convert_snipmate_to_vscode(input_file_path)
        print(result)
    except FileNotFoundError:
        print(f"Error: The file {input_file_path} was not found.")

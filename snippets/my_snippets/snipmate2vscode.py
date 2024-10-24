"""
File: snipmate2vscode.py
Description: 好用，除了latex相关的反斜杠的vscode snippet有问题，会多一个\t的制表符
"""

import sys
import re
import json

def read_snipmate_file(snipmate_file):
    try:
        with open(snipmate_file, 'r', encoding='utf-8') as file:
            return file.read()
    except FileNotFoundError:
        print(f"Error: The file {snipmate_file} does not exist.")
        sys.exit(1)
    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
        sys.exit(1)

def parse_snippets(content):
    snippet_pattern = re.compile(r'^snippet\s+(\S+)(?:\s+"(.*)")?$', re.MULTILINE)
    snippets = []
    current_snippet = []

    for line in content.splitlines():
        # 忽略空行和注释行
        if not line.strip() or line.strip().startswith('#'):
            continue

        # 如果当前行匹配snippet模式，则开始一个新的代码片段
        if snippet_pattern.match(line):
            # 如果当前片段不为空，则添加到列表中
            if current_snippet:
                snippets.append('\n'.join(current_snippet))
                current_snippet = []

        current_snippet.append(line)
    
    # 添加最后一个代码片段
    if current_snippet:
        snippets.append('\n'.join(current_snippet))

    return snippets

def convert_body(body_lines):
    # 去除每行开头的四个空格
    return [line.lstrip(' ' * 4) for line in body_lines]

def create_vscode_snippet(trigger, description, body):
    return {
        "prefix": trigger,
        "body": body,
        "description": description or trigger
    }

def convert_snipmate_to_vscode(snippets):
    vscode_snippets = {}
    snippet_pattern = re.compile(r'^snippet\s+(\S+)(?:\s+"(.*)")?$')
    
    for snippet in snippets:
        lines = snippet.split('\n')
        match = snippet_pattern.match(lines[0])
        if match:
            trigger, description = match.groups()
            body_lines = convert_body(lines[1:])
            # 去除最后的空行
            if body_lines and not body_lines[-1].strip():
                body_lines.pop()
            vscode_snippet = create_vscode_snippet(trigger, description, body_lines)
            # 使用描述作为键，如果描述为空则使用触发器
            key = description or trigger
            vscode_snippets[key] = vscode_snippet
    
    return vscode_snippets

def print_vscode_snippets(snippets):
    print(json.dumps(snippets, indent=4, ensure_ascii=False))

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python convert_snippets.py <path_to_snipmate_snippets_file>")
        sys.exit(1)

    snipmate_file = sys.argv[1]
    content = read_snipmate_file(snipmate_file)
    snippets = parse_snippets(content)
    vscode_snippets = convert_snipmate_to_vscode(snippets)
    print_vscode_snippets(vscode_snippets)

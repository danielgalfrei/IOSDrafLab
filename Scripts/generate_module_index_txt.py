#!/usr/bin/env python3
"""Regenera docs/module-index.txt a partir de docs/module-index.json.

El .json es la fuente de verdad. El .txt es una vista indentada de solo
lectura para consultar el índice sin compilar. Ejecutar tras cualquier
cambio en el .json:

    python3 Scripts/generate_module_index_txt.py
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
JSON_PATH = ROOT / "docs" / "module-index.json"
TXT_PATH = ROOT / "docs" / "module-index.txt"


def build_tree(modules):
    by_id = {m["id"]: m for m in modules}
    children = {}
    roots = []
    for m in modules:
        parent = m.get("variantOf")
        if parent and parent in by_id:
            children.setdefault(parent, []).append(m)
        else:
            roots.append(m)
    return roots, children


def render(modules, children, indent=0):
    lines = []
    pad = "    " * indent
    for m in sorted(modules, key=lambda x: x["startDate"]):
        lines.append(f'{pad}- {m["name"]} ({m["id"]})')
        lines.append(f'{pad}    Estado:      {m["status"]}')
        lines.append(f'{pad}    Inicio:      {m["startDate"]}')
        lines.append(f'{pad}    Ult. mod.:   {m["lastModifiedDate"]}')
        lines.append(f'{pad}    Descripcion: {m["description"]}')
        lines.append("")
        lines.extend(render(children.get(m["id"], []), children, indent + 1))
    return lines


def main():
    data = json.loads(JSON_PATH.read_text(encoding="utf-8"))
    roots, children = build_tree(data["modules"])
    header = [
        "INDICE DE MODULOS - Draft Lab",
        "Generado a partir de docs/module-index.json - no editar a mano.",
        "Regenerar con: python3 Scripts/generate_module_index_txt.py",
        "",
    ]
    body = render(roots, children)
    TXT_PATH.write_text("\n".join(header + body).rstrip() + "\n", encoding="utf-8")
    print(f"Escrito {TXT_PATH}")


if __name__ == "__main__":
    main()

# 导出单项成果 / Export one project

[按学科浏览](BY_FIELD.md) · [论文目录](README.md) · [项目清单](CATALOG.json)

每项成果使用固定的 `papers/<project-id>/`。这个目录收录该项目的论文、导读及实际公开的计算、数据和证明附件。项目清单为每项成果指定一个主学科，便于浏览。

在仓库检出目录运行以下命令。只需 Python 3 和 Git。

```sh
python3 tools/export_project.py --list
python3 tools/export_project.py random-occupancy-threshold --output random-occupancy-threshold.zip
```

可用 `--ref <commit>` 从含有项目清单的指定版本导出。ZIP 保留文件原始字节和仓库相对路径，同时收录公开论文中实际引用的仓库内文件。解压后从顶层 `README.md` 打开论文或复现材料。归档会补齐可由现有公开代码或结果确定对应项的旧路径。其余缺失链接会计入归档说明。

Each project has a stable directory and one primary subject category. The ZIP contains the Git-tracked project files and the repository files cited by its documents. The root README links to its manuscripts and reports the number of unavailable relative references at the selected revision. Existing ZIP files are protected from overwrite.

## 新增成果 / Adding a project

1. 使用稳定的学术题名标识，在 `papers/` 下为新成果建立独立目录。
2. 同一项目的论文、复现材料和 Lean 补充放在该目录内。保留准确的学术引用和验证范围。
3. 更新论文目录、按学科浏览及 `CATALOG.json` 中的主学科、稿件入口和跨目录引用。目录中的学科 ID 与项目 ID 用于稳定链接。
4. 实际导出该项目，检查归档条目、相对引用和起始阅读入口。

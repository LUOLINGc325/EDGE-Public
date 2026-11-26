#!/usr/bin/env python3
"""Export a single tracked research project and its cited repository files."""
import argparse
import json
import os
from pathlib import Path, PurePosixPath
import re
import subprocess
from tempfile import TemporaryDirectory
from zipfile import ZIP_DEFLATED, ZipFile

ROOT = Path(__file__).resolve().parents[1]
SLUG = re.compile(r"[a-z0-9][a-z0-9-]*\Z")


def git(*arguments):
    return subprocess.check_output(["git", "-C", str(ROOT), *arguments])


def tracked_files(commit):
    files = {}
    for entry in git("ls-tree", "-rz", commit, "--", "papers/").split(b"\0"):
        if not entry:
            continue
        metadata, encoded_path = entry.split(b"\t", 1)
        mode, kind, digest = metadata.decode().split()
        path = encoded_path.decode("utf-8", "strict")
        parts = PurePosixPath(path).parts
        if kind == "blob" and mode in {"100644", "100755"}:
            if "\\" in path or ":" in path or parts[0] != "papers" or ".." in parts:
                raise ValueError(f"Unsupported archive path {path!r}")
            files[path] = digest
    return files


def guide(project, commit, names, related):
    prefix = f"papers/{project['slug']}/"
    lines = [f"# {project['title']}", "", f"Source revision `{commit}`.", "", "## Start here", ""]
    for path in project["manuscripts"]:
        lines.append(f"- [{path}]({prefix}{path})")
    for entry in ("README.md", "REPRODUCTION.md"):
        if prefix + entry in names:
            lines.append(f"- [{entry}]({prefix}{entry})")
    if related:
        lines.extend(["", "## Cited repository files", ""])
        lines.extend(f"- [{path}]({path})" for path in related)
    if project["unavailable_links"]:
        lines.extend(["", "## Availability", "",
                      f"The original documents contain {project['unavailable_links']} relative links whose targets "
                      "are absent from the source revision. The archive includes the files tracked at that revision."])
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("slug", nargs="?", help="Project directory name from papers/")
    parser.add_argument("--ref", default="HEAD", help="Git revision to export (default HEAD)")
    parser.add_argument("--output", type=Path, help="Archive path (default SLUG.zip)")
    parser.add_argument("--list", action="store_true", help="Print project IDs, categories and titles")
    args = parser.parse_args()
    if args.list == (args.slug is not None):
        parser.error("give one project ID or --list")
    try:
        commit = git("rev-parse", "--verify", "--end-of-options", args.ref + "^{commit}").decode().strip()
        catalog = json.loads(git("show", commit + ":papers/CATALOG.json"))
        projects = {entry["slug"]: entry for entry in catalog["projects"]}
        if args.list:
            for slug, project in sorted(projects.items()):
                print(f"{slug}\t{project['category']}\t{project['title']}")
            return
        if not SLUG.fullmatch(args.slug) or args.slug not in projects:
            parser.error("unknown project ID. Run --list to find available projects.")
        project = projects[args.slug]
        files = tracked_files(commit)
        prefix = f"papers/{args.slug}/"
        own = sorted(path for path in files if path.startswith(prefix))
        if not own or any(prefix + part not in files for part in project["manuscripts"]):
            raise ValueError("Catalog does not match the project tree at this revision.")
        related = sorted(set(project["dependencies"]) - set(own))
        if any(path not in files for path in related):
            raise ValueError("Catalog lists a dependency absent at this revision.")
        aliases = project["legacy_paths"]
        for destination, source in aliases.items():
            parts = PurePosixPath(destination).parts
            if (len(parts) < 5 or parts[0] != "papers" or parts[2:4] not in
                    {("evidence", "code"), ("evidence", "results")}
                    or ".." in parts or "\\" in destination or destination in files
                    or source != "/".join((*parts[:2], *parts[3:])) or source not in own + related):
                raise ValueError("Invalid legacy path in catalog.")
        output = args.output or Path(args.slug + ".zip")
        with TemporaryDirectory(dir=output.parent, prefix=".project-export-") as temporary:
            staged = Path(temporary) / "project.zip"
            with ZipFile(staged, "x", compression=ZIP_DEFLATED) as archive:
                archive.writestr("README.md", guide(project, commit, files, related))
                for path in own + related:
                    archive.writestr(path, git("cat-file", "blob", files[path]))
                for path, source in sorted(aliases.items()):
                    archive.writestr(path, git("cat-file", "blob", files[source]))
            os.link(staged, output)
        print(f"{output} ({len(own)} project files, {len(related)} cited repository files)")
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"{error}\n")


if __name__ == "__main__":
    main()

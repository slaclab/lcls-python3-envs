import json
import subprocess
import sys

# A script that can be run on our dev or prod networks (or anywhere else) to generate a simple comparison
# between the packages in two different conda environments. Outputs the results in a format that can be
# used as a table in GitHub release notes, can be edited further as needed.

def get_packages(env_path):
    try:
        cmd = ["conda", "list", "--prefix", env_path, "--json"]
        output = subprocess.check_output(cmd)
        return {pkg["name"]: pkg["version"] for pkg in json.loads(output)}
    except subprocess.CalledProcessError as e:
        print(f"Error reading environment at {env_path}:\n{e}")
        sys.exit(1)

def compare_envs(old_env, new_env):
    old = get_packages(old_env)
    new = get_packages(new_env)

    updated = []
    added = []
    removed = []

    all_pkgs = set(old) | set(new)
    for pkg in sorted(all_pkgs):
        old_ver = old.get(pkg)
        new_ver = new.get(pkg)

        if old_ver and new_ver:
            if old_ver != new_ver:
                updated.append((pkg, old_ver, new_ver))
        elif new_ver and not old_ver:
            added.append((pkg, new_ver))
        elif old_ver and not new_ver:
            removed.append((pkg, old_ver))

    return updated, added, removed

def format_markdown(updated, added, removed):
    lines = []

    if updated:
        lines.append("**Updated Packages**")
        lines.append("| Package | Old Version | New Version |")
        lines.append("|---------|-------------|-------------|")
        for pkg, old, new in updated:
            lines.append(f"| {pkg} | {old} | {new} |")
        lines.append("")

    if added:
        lines.append("**New Packages**")
        lines.append("| Package | Version |")
        lines.append("|---------|---------|")
        for pkg, ver in added:
            lines.append(f"| {pkg} | {ver} |")
        lines.append("")

    if removed:
        lines.append("**Removed Packages**")
        lines.append("| Package | Version |")
        lines.append("|---------|---------|")
        for pkg, ver in removed:
            lines.append(f"| {pkg} | {ver} |")
        lines.append("")

    return "\n".join(lines)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python compare_conda_envs.py <old_env_path> <new_env_path>")
        sys.exit(1)

    old_env, new_env = sys.argv[1], sys.argv[2]
    updated, added, removed = compare_envs(old_env, new_env)
    markdown = format_markdown(updated, added, removed)
    print(markdown)
